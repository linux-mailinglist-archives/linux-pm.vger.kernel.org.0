Return-Path: <linux-pm+bounces-38758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBCC8C45B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 00:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C5AC4E0700
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 23:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BDC2BCF7F;
	Wed, 26 Nov 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="XkTJr23L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B824207A
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198037; cv=none; b=YCAWoLMFurmO+jAA/FfK0D6ghL0vhNdKs/97HNJMl6vPOrRTMUnIrp2IsiR8TKhC+i6N9Bbr2IlGjnG7dhTTBKnilV6mqqqPQSHQgYY3STQH4J+3LOYtX3THP9rjtP7vdt7P19dLQiWyMzlwPlUeLSvVaSR/vVkE/NvQ2O6sPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198037; c=relaxed/simple;
	bh=PCSoXnpEk3pcBjDBHwldkbFyBOfxd01QtGIpFU03GsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=uIwiQYwsU3sBtoIrKuZppDbL8OrAvwdipixLDaOMYAVN9T9IU2XkHpLpXZVZz5iJqA+aITIKIbG04WZFqmOkrug4BdHunI1BZlfo4+ABmsofm4EloeuZyMqDwjWox0bBENnoE5FJ3yqH6LpSTcV3N3p2Qzy+fZGiCXr2ynuPx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=XkTJr23L; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-434717509afso1695055ab.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 15:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1764198035; x=1764802835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCSoXnpEk3pcBjDBHwldkbFyBOfxd01QtGIpFU03GsY=;
        b=XkTJr23Ltz3Gws0weCYDMAQRz3HrZADjE+qlLXWmy3CqViWpDaHsk8CTDa9Z6SK8af
         CwdgcZQhSLaIlixnf/l7XjsZ24f8nPLoP7JQQTNTnbFh+RvFvDybKAEF28kBcB608kxO
         sm/e7qV99i+jf5g3fhsv9iAGm/dHxyhCTiSDAc9DL9Y/lJj9493+A0SJPoXm0FX6CEfZ
         8cjAZc43gKGtWsUWj2241RQMryE8R6uOFqmKsOpo0KkmfrOZkfAuKX6Q+lDc3oNEajq/
         6sgvczQDFawlORlLwdH+QW6R5sWQ6PV5gvCe/8LGoA/pLLFwbh350qx4Sz1tA+YppMA6
         NHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764198035; x=1764802835;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCSoXnpEk3pcBjDBHwldkbFyBOfxd01QtGIpFU03GsY=;
        b=C2yBn1B41BuLxHN7ivVQkiu/ML1z4HeJNxDXSjn7ZI/BQLsCpwt91UZg2KZQIjBHjO
         H/gD01+3/6q+xLvP9XMJBE9/uvOPfqBuzEWqft+f4p5D7+OOn/10UNahOqcyVwXhWCN5
         QYOOEEOKXhj9HjcV0W6/gXHqe7SFzkd4KpH4B+Uva9sfqybxfcFXzdRIrEnZiNf5sftS
         dUy95GsTpxby3AnVUhP3WjofCmlTvgLrAJZmIMAwVzHvgv94iVY4PBUyDEMSWM7iDe2K
         ntNz4qb0vAKaRVIob8cJHSCbUVJMneuGmLKlw9vdD0XcoF00EMqP9CVYk/na5Oxtxynd
         MMMw==
X-Forwarded-Encrypted: i=1; AJvYcCXsMcpWJ5eIylWpB9wmJ3870F4Yoqi7+gYV1Wr5NEX0Nv3zL1EAfkCUXRLjsnLMEk0BpV0TfKlR/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2HK4dRUUZsRX2f8iT15lGIVC9nJmfjf81AXpCuiTj+yPAm4F
	yw44+7nazdY3eudu1C5BYJ6D4/GVuj14LPEOMiF1ClyXSP90zgoxMFDx2ewNISpHOYI=
X-Gm-Gg: ASbGncvpPpkgXMNsoy1pGLSg8Y9ZEUgnTBakIz5QCbD+NXcRN473CncjrRV/JpExVVb
	5+iMIU38p+jaYbDZmJNkbnSe0AEMP2+auTC/PYJUSTeoQLgmEoe2y6g4paE25mRGASRCROU7tbO
	eIMRv3F994cNUK9nrKodcBQAB1FeWduYKsxloV8/qFmxSNPoozzCXmFObpG5iqg3rpKnimu5zjI
	7xZnfePl/fsooRcZdC+ka3zO0hgn5jS8Z4DNVfzSz+NTNQKI7uB7CHughg7x+K1sxOg6K05/RQF
	TsrS65C3CI9nn9IeXHhDj1m6LrgGAKSNl92fg8yIIFM4JF1kvyiH8Z3NhKolxJqeQagNOwwKz1T
	+tTRL5PmwdAa2u7hezJ+jpCLbzhxV16THLvNklAfeiemDVG3XbTjgrCiCwmUhxnGWOAV4AqwxR3
	NbZvGPVbcH
X-Google-Smtp-Source: AGHT+IEWc+r1Rn9tHnOOwuTgILo9tXvn4RuBZcp34oCrRbA7eLq90EYdlKPbB6iWPkQIPBS3z+8L1A==
X-Received: by 2002:a05:6e02:198a:b0:433:2341:bc12 with SMTP id e9e14a558f8ab-435b9851db9mr197827775ab.2.1764198034546;
        Wed, 26 Nov 2025 15:00:34 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:bf0b:8b65:49b1:b694:940a:bfe6])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90b6dedsm91960055ab.18.2025.11.26.15.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 15:00:34 -0800 (PST)
Date: Wed, 26 Nov 2025 17:00:31 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com
Cc: arainbolt@kfocus.org, kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 mmikowski@kfocus.org
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20251126170031.145b6a56@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
In-Reply-To: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

(Sorry for this rather malformed email, Claws *still* can't find the
thread for some reason so I'm having to resort to a "mailto" link off
of lore.kernel.org.)

> I asked for some dumps before. We can try to inform the OEM of the
> system as this is a BIOS tables issue. What is the make and model of
> your system?
>
> Thanks,
> Srinivas

We're actively working on getting the dumps you mentioned previously
for all three affected machines, along with the model info and some
benchmarking results with our current production kernel and the latest
mainline kernel. It's taking a bit longer than we expected, but we're
pretty close. I should have more info by Monday if all goes according
to plan on our end.

Thanks for your help!

