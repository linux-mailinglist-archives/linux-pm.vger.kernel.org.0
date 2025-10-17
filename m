Return-Path: <linux-pm+bounces-36347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD882BE817C
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CC7D501D30
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671A831282B;
	Fri, 17 Oct 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIsJBmJr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0E312801
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697582; cv=none; b=eN/i7hxpIFWnVReG+ba9gfD0KKEeGSCKuMpkgXYWyeEge8nqgPHLbY4kWgjduzej++44ovs+ZB5m30e4UELWx9dG75lngajRA32uE3uiYGurkrf1SH4XmprLBVLUgIM7XlUJDly0fs8sssuEdgNCHK+ByMAFbfjaUzQDu+FSBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697582; c=relaxed/simple;
	bh=3icRH0liAsP7sjwZ2zPe1LVJ+1rHNTn97LK8vpGCQW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adu/uPUUoxCDkxpYwtz1IUa3+poYp3CZ1rkU985FksxixQM4iTYy7Njnb6vvpDfE5siwxiFeZrYWWkXxEH6DH+v9uxtemq+o2HrwtYu1QQlwJnunRkkPlpjuYKShuXNSgt19NndUKYgL5jWxnI+4jBStuo5Rp2mS4ENmAS0537A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIsJBmJr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42701f2ad61so749865f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760697579; x=1761302379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7jEt2bBtS4lkQKEiP8Z3A8t05k/u/Bf60nmYvlGeNY=;
        b=PIsJBmJrMIRiaJc377tUJB/Q7jAPNt+/GfB5DIWte0H+rpzZbktzK6V+z8PoTBEV3n
         PXbatbbxsvCpMeXkPh4Pkvh9x+HOK6mzX+0OzVatQKjGwmZNV11fZy0DnubGUWu7nJ6n
         jasj0SZuwGnlUMILN0xZgaeY076K9PTQujkfuVbgDDdSQScYdhhewD9JZRaz7iP2vrle
         zdS/rqCAViynmb7CQ9RZonSn5DVK1QXDKU5pNP36zNP9FclbCe3nm03cJVXUqgw3fUq8
         SlR5IsNq8+6DmDNdOTasECZ6L6JHpgAA6tHuKzz0GiHqzUiWMXyEmbkzyepPkpPIooHQ
         mHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760697579; x=1761302379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7jEt2bBtS4lkQKEiP8Z3A8t05k/u/Bf60nmYvlGeNY=;
        b=qvGxN1g66AzpNuVHOyIZTIo9/AUuImeWYXiT9YOsE04QXzd+/kaKhNF2VLPQK1QjHw
         jF3snn8bmbBbjroA1om3aJQyxCzpu9JwS/znj1krcdfP/6MREzzY3bzQQLax5nn0lbr6
         vtCHlKjZ5Tb1yuWVheKZGTBuAv3zu/RnwsbVGn27lVWwdxhOjGm3FiFem67padN9G2ge
         7vZ2f71enzyNChq+yF5xciZG3tRofGvJwWkBmi1fHWUwuKfqmoYSLpY26bKbd+rfiiZd
         y48hQBKk6B5gbKOWrCSPJ3kzQGvPf50SZN9YqDeF/JBTkUd1Ol/3xfpYa84nit808nOj
         a7tw==
X-Forwarded-Encrypted: i=1; AJvYcCWfAnM0/Pqqny9ALY2ZGstLSVW0xCTpu+VWQA5DWrCy2vNpKYZ1p3mWatnyJ4+W6kyaQRChJq63AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCd9bYY4vUcpTpJnxGcoEvYqTASzuVSSmPr7ZaHSe3edfleEu
	ai7hW0W0CFUwr5cuSXR8jCW5hYtrenObXdPpA/AZnLpXcRtlj0i3dg7FXoqdKIil
X-Gm-Gg: ASbGncvVGWUcFHPm54Dejc+4gHv93+HA/nhB98BIbkukMHeCqQxGzPJv6eOiN4H4p07
	9CrNTwbMCLcsdXHJBLm82XDgKdqWhmeqcsvjZqp50veMHjBJT5yAh0mfkqDVaHS0XJ8ij2AwCFS
	obOOlIPeRs9tHpTQj7rCRpQjDulXSTxIZXuVmOPrbDR6SUpsYUFOt8j7h+WveE5s7pJ1UkCSrQe
	r4WELy3bvmgDw3g2CKjH3haJ1UvZ4RWc04jTvSJGlyXttYCXeNaPznOFRqypWi9cENp35vd7ttd
	tq1IHTkqpQW3zIYuA2h7lYjlj0FwRvE/wrqwIOnHnWbGWMDQhn1NQQVkQzqJ6+e80wRFnpSpKth
	aEAOmdNVOt/OVZNyn2RT9TxS5/1yCkG7/QvDMk81cgZRvAQ9i3sOWTrM6Hkdnaj5ICdpfy4rqni
	kMTN08cC/9JTI5CtrJQpfJhA==
X-Google-Smtp-Source: AGHT+IEHuo1AdfTtiQhHrCKaYLVYpg367t+Hy0cy8LVgBCFvR9kcQy/2El+YmymF463hMk6d8OPEzg==
X-Received: by 2002:a05:6000:400a:b0:425:769e:515a with SMTP id ffacd0b85a97d-42704d9e8f7mr2460323f8f.42.1760697578950;
        Fri, 17 Oct 2025 03:39:38 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e10e8sm40199791f8f.39.2025.10.17.03.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 03:39:38 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: quwenruo.btrfs@gmx.com
Cc: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: Long running ioctl and pm, which should have higher priority?
Date: Fri, 17 Oct 2025 13:39:32 +0300
Message-ID: <20251017103932.1176085-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com>
References: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <quwenruo.btrfs@gmx.com>:
> But there is a question concerning me, which should have the higher 
> priority? The long running ioctl or pm?

Of course, pm.

I have a huge btrfs fs on a laptop.

I don't want scrub to prevent suspend, even if that suspend is happening
automatically.

> Furthermore the interruption may be indistinguishable between pm and 
> real user signals (SIGINT etc).

If we interrupted because of signal, ioctl should return EINTR. This is
what all other syscalls do.

If we were cancelled, we should return ECANCELED.

If we interrupted because of process freeze or fs freeze, then... I
don't know what we should do in this case, but definitely not ECANCELED
(because we are not cancelled). EINTR will go, or maybe something else
(EAGAIN?).

Then, userspace program "btrfs scrub" can resume process if it
got EINTR. (But this is totally unimportant for me.)

Also, please CC me when sending any emails about this scrub/trim bug.

-- 
Askar Safin

