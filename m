Return-Path: <linux-pm+bounces-38405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28022C7D9A3
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 23:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D004B3AB89F
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B1C273D81;
	Sat, 22 Nov 2025 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4EYqLjM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376421B918
	for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763851677; cv=none; b=e9wMN7YSb3YY4nKYU6sPwe0tyeXOFSTOZcM/cHOb9jpIAmn82RrTmZQ460U3mF60qHbBMiWGw9cva1Gc3eVoSDFNQBQXxkTGagkyEsuEEGAhDNzIlAvYcht0mQ+Z/VIc0Afb6fULpffxQYLGzFaNueDfeJPBKAdHmDXC+5364Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763851677; c=relaxed/simple;
	bh=mDmOqDRRV1GxRTkt03uYnfvm5YBI/u/mWZasnkUTwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqMx0ATyO9eAgm8yyaWYKa316lAasp9AImXBB5EGKXCeeSXxQf6MQd/UumainAb4Iu9UX76JRovqr0gqQVba13R4uIIw+3Hpi1Qx56uV44yywl+C0spky1Iaggv5yfjMP3t5pmFvqMa16qo6nz4qgTSrgsj0vkqH1KKrL2gyd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4EYqLjM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so3858684e87.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Nov 2025 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763851674; x=1764456474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mm9cJVhutkedd51ycbYwKmMqp19QwPFiX/ffFg8rVcg=;
        b=m4EYqLjMnZAClasW5oW/RKRiG7pn1i/2sd87a2+bGT5arzuzX2s9OWunw3ssNpcdIL
         Rt3hNDSuFUBrtfbXvhjdipl2gBlBuevvx/2V/Sci3GW099P+W5/rd7vFyuWpyVXP1yQP
         MK62n9rzpZxAKODtmj7axGjtZm2iPhssZ7V5ietC61jcOyFvK9Nmes+GYZJ0bfVVY9W3
         HhsNbNtfDCgWUxgyoFMe3TEbEmFHKPlLJzBCay6GBLVkLziLLWupjzRTYCBTQvVTCNtC
         PCE0gN7ui5o9znFYb9NWADBrbgacrALeEnX1YBs7J3e4rCG9ErcZLONAjVpKnh7gKzq8
         xDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763851674; x=1764456474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mm9cJVhutkedd51ycbYwKmMqp19QwPFiX/ffFg8rVcg=;
        b=GfxwcnHspMD8CLiedbXWWY1aMg4AJfG7689SfusR4SRt//0HGq9/C0VB/VF12QRAYR
         08P/44HdU27e2CuoMFExPD8AMVK8XzpNqXIljomOHY+miYj9dRDLU+LiSHUeh6QV2aE7
         RtOlpu7WEg6YggHF0Esgzu/6ovqTo+3G0K9W7cUQlTwg6Y81cXrtP+Fm8v3FlXkcg1Nm
         BfqDQXLIYpQMcEem37Y3679Hs9SKVWUFf+BkAZ4rjHlaK+EV3yWNZiKBpyc54MkSxwMO
         u76qRVxYQYQOv18TibKJHwoEvvAUMaHiqTEJBOEFqcsm0uJLweMYcAjN8pl6sCmIRugP
         xKdA==
X-Forwarded-Encrypted: i=1; AJvYcCXGLKDI2aMxhkkI7dgecPS241W9EYGWZWqPdOZ4kl+CBkNyySApa2u+N0I37dW1ezwkl3YOZQat0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzamtA3/1o5oSAmKaGRsCZXUVwdPIuTvU+1NHfDv677tZl/Fjdp
	Jz2XPjFJZuNBUOF7mIcgPu4w2+5DHOkdaajHk+99EkPNe80ls0LSWqXs
X-Gm-Gg: ASbGncsQCeHimxURD3IzSOguPf0ZYXUYbuObI2A9QpqSDYPlm9U24JScM9j/DFGpOkP
	VmBfhZVMhzoG3QPBYyFi2/HJVLwboGjGMseCw7IEL/UZFWeQQ7T40amzT/lRP32SYlWwb8qvkzO
	jbr9lCCPTrzlpAVb+w9XH1M1FPz5fzfUtTe1uvh3kqPjmPYS40LK4GY7e/rRyP9Jt+S1vwMnMav
	99UPDk+Ec01hYAmF1T3UTlZMePLggRNYN6CgUQg+YnrPUD22c/WKHCoTu4j2f52A0G6yOcSEBkd
	69s+nYmr1PkWSGwUzyGdR7DU/KYDNV8IUE7Sq8ewqmYOj73AFyl2jiEQBnZnzL7XNBGsgbmY5vY
	96ooateM3+PGCUylq+9LOKu/mnTd8ePCL3DvnnlmJr354pOi5lU/nh/A26+STKo8BK6ENDvBfXN
	lqF2cpvztOeQ==
X-Google-Smtp-Source: AGHT+IG25dEQnHwaBToxpvBjTeZ/3RB3yCymIb0k9rzfOt31nS8ruDCrSu8IePguUMWt0EMXA9m5xw==
X-Received: by 2002:a05:6512:308c:b0:596:a000:596 with SMTP id 2adb3069b0e04-596a0000a2bmr3428587e87.10.1763851673743;
        Sat, 22 Nov 2025 14:47:53 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5969dbc5988sm2742367e87.78.2025.11.22.14.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 14:47:52 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	agk@redhat.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	milan@mazyland.cz,
	msnitzer@redhat.com,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
Date: Sun, 23 Nov 2025 01:47:48 +0300
Message-ID: <20251122224748.3724202-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> [PATCH 1/2] pm-hibernate: flush disk cache when suspending
> 
> There was reported failure that suspend doesn't work with dm-integrity.
> The reason for the failure is that the suspend code doesn't issue the
> FLUSH bio - the data still sits in the dm-integrity cache and they are
> lost when poweroff happens.

I tested this patchset (in Qemu). It works.

Here is script I used for testing:

https://zerobin.net/?66669be7d2404586#xWufhCq7zCoOk3LJcJCj7W4k3vYT3U4vhGutTN3p8m0=

Here are logs:

https://zerobin.net/?5d4a2abbad751890#WMcQl4FAZC9KqcAuJU3TSVr7wuVnPFwI7dlinA9QHOo=

Tested-By: Askar Safin <safinaskar@gmail.com>

There was no any reason to wait for me. You could easily test using script above.

Also: Linux shows this scary message when booting in Qemu:

[    0.512581] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

So, FUA is not supported? Does it mean that this patch is wrong, and works purely
by chance?

-- 
Askar Safin

