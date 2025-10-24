Return-Path: <linux-pm+bounces-36795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E346C07520
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 18:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCFC1C285DD
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D826ED2D;
	Fri, 24 Oct 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baeGrPtx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFD244665
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323514; cv=none; b=szPoohx4YXSTZFcyv0X3xTfjlV2VDbjyWAl2PJCNWtpUd7gw6Tra6mYbJkey4fh1Pf0xfXepz9CpEpKSVdqzX2EfM/BHtSgksOmtj3y+L6OFIb13x5698sxNP8dxNxJ4Z13Mha4HBAYVoUzovFFyc8/xOGdcu84hsWi+DoZt16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323514; c=relaxed/simple;
	bh=2sni659oKETAt3mg4JWKS26aiVXJeHNTGhbFaOETvpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsL/67CnWLZ04ik8JbSXV5UeRTmWgVPNHZTa6npkJODUMzNUFZxrmdrhCnKFxprvKPYCFMUnNUAsH10u1/QrafyPYWjooEslwxEPZW659K7+FzTlKixRj5Osl+ASuMlQr7tHSMIFRBWIRxCtPe6Lub9SbpaoqvsTN9v6rnDBN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baeGrPtx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso4239650a12.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761323510; x=1761928310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU6+xLScjAoCvkgYL37muGkf8RRryUsuClOGQPNvZ0U=;
        b=baeGrPtxRl9Zf/t4igHdLAfWz7seyMy2nyivr30g2fvYihwprt8qlhOJ9DJtSB1hBN
         TYLvarvSWtjgZgxIFPLdBYl4+zOt6KrUsmyze798Y9YVrE4BJz0upn4uZAdQ0Qm/C69Y
         73LY1yYKOXRCr1VXZQAMZHTQGiaqwXIQl+XOrqPkJ6DJ3WbI8Lxosftc+V1hDcagxFE+
         Mv+ER1/NPEMnCHB5T/HRmKAwwHUaJG509q9O5YZGfQ2xoBy9R407zdmitycuDi0eGZZ4
         4CdnBpGwx2duUok2tRLKfKZLcZlsr35nVFeaUcTiP2b6iztLXtbn99MOpppdextVXb3r
         L0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323510; x=1761928310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OU6+xLScjAoCvkgYL37muGkf8RRryUsuClOGQPNvZ0U=;
        b=sQtpe0EiWX1LIszfaN5G5dOTUcnN9KU9emRybFlIEOk/cZ55Mh3NZR40iMC/051f4Q
         Uen/SKpA3DcTaG2e+37RmRqo5Nziu7u4V0i+G9/nMUxXQtRIIQUbH+GhHfMaLyXzl72P
         I8qYK9SWeOsbG5tlrPsW7ahR6cKd3c9noe1u7SyjfScJ1phO3/tycivSNJHzHI+09+ao
         uEP1jj6tiaRhtYQlazQvES9n259vii6YEDl0a2AEcfhzMOYkBdXk2/T2DHdY2rBQKW3H
         wXQf8V2aWt4HHPne2sP2+lrNmUJimfH9yksm6IMiO75u+eaHGvTTLzELgAKNVYnGtDZ8
         3SFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWroeoPHkp6uJYyLOhcUZDBGt2M/HSEDyJHMFU164dHbdkUQNky9ws4t6/ayyUyQFpKwcCRyPX/dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8c6FtC2iut7nhnM90e+sd7xaXgDkz3yZiGOGBTShfn43WSp43
	i8GFvNE1BIsq5Xk6KIzMyjMkN7oSErBRhkLK2B6vQgKvF0Axb4YcLYBb
X-Gm-Gg: ASbGncuJ9d0pV9UPOpX/PQSTaNYQ8bSWDr2Iq2wSqGREEHEsBX3Sa+i7rmWawr/LYvz
	jo8PNvOpELsY74eLrGf98hmF7DfrFbPCGHas1se1k9Wv5c+LwoFsO6LzL1H0rsNOd8toqKfCcjB
	rqCO7Gvv27OylkZtOl9RG7DLxXvZhO1Q6mLPC45cdNya5aHTNwoH+qmDeuIabbS4vBijaY/Ax3g
	vLdU0FLODs08/+CMwlq/IQ9CC6emvRpINpuzIp0yOGrmxq6hAJNiTa0N27ed9kGh9OsUugIJ7Qj
	i0AZ3Azch1WxNONoIOmUrj/7OXqtKmtD3UhDI1+JOQYyhwu8E1rsK7IykERiqXXoSCQ1x6lC4tw
	TiMqOzo4m6x3tfHUhZphQlyn3+f5KWcqcCaiQLdjB4gbXW6gW4M3q3p5WJMa2R8P94C6YnCN0KE
	8X
X-Google-Smtp-Source: AGHT+IGJrzUB5n97Ss2T/JTlLzP7kGDtRqESJivToHOWW6+qmykXupmsLuZ+wNfM3MQ1VRw6GaGwKg==
X-Received: by 2002:a05:6402:42ca:b0:63b:fbd9:3d9c with SMTP id 4fb4d7f45d1cf-63e6002459emr2596805a12.15.1761323509904;
        Fri, 24 Oct 2025 09:31:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e3f316b64sm4717822a12.22.2025.10.24.09.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 09:31:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
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
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: dm bug: hibernate to swap located on dm-integrity doesn't work (how to get data redundancy for swap?)
Date: Fri, 24 Oct 2025 19:31:42 +0300
Message-ID: <20251024163142.376903-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com>
References: <a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Hi,

I just wrote script for reproduction of this bug in Qemu:
https://zerobin.net/?4e742925aedbecc6#BX3Tulvp7E3gKhopFKrx/2ZdOelMyYk1qOyitcOr1h8=

Just run it, and you will reproduce this bug, too.

Also, I just reproduced it on current master (43e9ad0c55a3).

Here is output of this script on master:
https://zerobin.net/?68ef6601ab203a11#7zBZ44AaVKmvRq161MJaOXIXY/5Hiv+hRUxWoqyZ7uE=

As you can see, hibernate succeeds, but resume fails so:

+ blkid --match-tag TYPE --output value /dev/mapper/early-swap
+ TYPE=swap
+ echo 'Type: swap'
Type: swap
+ echo /dev/mapper/early-swap
[    0.446545] PM: Image not found (code -22)

Also, I just noticed that the bug sometimes reproduces, and sometimes not.
Still it reproduces more than 50% of time.

Also, you will find backtrace in logs above. Disregard it. I think this
is just some master bug, which is unrelated to our dm-integrity bug.

I will answer to rest of your letter later.

Also, I saw patch, I will test it later.

-- 
Askar Safin

