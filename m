Return-Path: <linux-pm+bounces-39817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D620ACD7B02
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 02:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C03A301177A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 01:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5434B18C;
	Tue, 23 Dec 2025 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfOsId7s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBF34AAF3
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766454091; cv=none; b=tf6Q69Vlnq1cuEGr4xz+akczULMyxseevLApgj+t3Nz0VAjp13X/BgPsmaFY5n35auALs+vK/3h5Chn+xs2+A7azD33jHWRzfN+vk+pI2E6s1NYCVIfSK6G4+gdVtA4htWrgskjiHLMtlHGVpSbXejBXWxIpWb5XseHWAYrOAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766454091; c=relaxed/simple;
	bh=Dw1tVh0CmnWqKDbnt9xHH3i4dpkMlWgLPtv4rSVZoxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb1+Ru68OjCEY7d198CYqso/1y2KJ5dEqbaigI8DO+78twc6/phQpAlrVRB9uUPOFe4NUsbNxaONFIkzbIHUVlHqlxOUpBTcwGnY9ZgYDICEgs6l3YhDEzuKvZ7lfWPYOr/CCpy6E0HjrJPwxjs4ATU+e4RNb+zYnCXnUPhossI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfOsId7s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-596ba05aaecso4556383e87.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 17:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766454088; x=1767058888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzc2azkAT7+UZs63CJT4nkeSpZYqRpvq+hUurVd9/nU=;
        b=OfOsId7sIcDGQy2pTh1vUpxLeUMu89wMN8s4Lk5g1kjn6irxsnAKWeUrpNqRGyoG36
         KeetWAt4xPplCAfvWllRU2qX5LiXDYmB4HICp0vluIlAJj36byf5FlO7IURPnAFcLIfz
         EdOrskXj59Xi4pyqUHPyuUwgjUIFaXZtWIz1k+TrIRp3q+8hANEkpNpTzlkL1uX3AgQ0
         ZClbOvf3LRxSqsQg1qNBWzRHYzc57vVVkz/mG+VKQYTkkt3PAwUnDwDy8f5K8XKVszoR
         AeOMq3ZA8JcsAWy+d3QFwQ9mUBT9ymlXsOOpr25TL6BQd5Dr8Z9ZO80mclH1UxWOzlrI
         yN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766454088; x=1767058888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uzc2azkAT7+UZs63CJT4nkeSpZYqRpvq+hUurVd9/nU=;
        b=eo4ykDwcodg7biQiyAHN66occzO4EBINW2IQMQQtfXsVtDTxfojKVk+U5dS4ooxXIB
         qyMfNZcf8mQGe+mpbHQWoVyGrFHDyRSPy7lKNbjWwl84RR+6xOCGIkkHRq3hbWIMdaBl
         GQt/6AUzGVaj7OeeeVG1UiIYO5DYGnTjASjMTme18J6H8tY9S+RoKxJ48/BPuKT9fZSz
         TxYvl0VZejjx/S+vksCugtbQPrAfLZzZy6dLT6JaZpcfcoMKyNzKboEFo2ubIgjY7yP4
         NK+DQtDXgHzEVBL151hvSUhJdexMfTOsDgZ/TCjk49CmsB9S5BAeQQmTtRm+q17Lq+mg
         2FzA==
X-Forwarded-Encrypted: i=1; AJvYcCW9oR35eVbGvtByuK8keGwHba34C7/iuTFl+HH0ZH59AvFYQif2zVzQcbt0I6IDbPg7KF34zQh2hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCD9UV99dPg2nsmuQzjtcinilA9JvH3fQ/JnemqOeLwnz3+DMQ
	Js9+dS12BhKrZ7wkCsir5bmMTG4oAHKMCD1e587zbCQldJjCaSi8ErJL
X-Gm-Gg: AY/fxX4OM/OkPqIj6j6KURecVB+FmSivTYHT1b5xlpiqa1tF4b/ZXQdqmIH2aOFahSr
	+jelw9KVrMgNfBZxcEJVNZA6M/MIoQvOYAIMVwg9t47KI1u88N3oBEW+3BTDvmKI7bLwEeqR7Sg
	yu+SNoeNdvJm8bPHjzHs8+2PK13cmCXm7rIIr9BEu0mFjGio8e16RqrcYe9ri0182gw7yowJSqi
	1ifp/BDCG7yuiS0far4e0zDzBIi/Za7Fa4oeqeBev7icNkgD9J2fwi6xIK6akS1/z9J9PjyvKv2
	8B+/fNnCRCresOyvoNIw05iFaB6pqu/A7jCGXW67Osw6ttzmbzkBPzd6EV0+nQUc6l/awEsjEGY
	ia5r/sRJAEUea3JmZhvG4/C0q6OhTjaAcB2MVOIrqzLTlbAgtRH1N0YaBvZdM26QLth2ElmoQ2l
	RQiIXQczbe
X-Google-Smtp-Source: AGHT+IHWUix04V1tUMjJhj8LmwIJFsrYjMJ2eegt/yizChdKwHOARh8H0MmDtl7KvKnzF0od4dTcxA==
X-Received: by 2002:a05:6512:234b:b0:59a:123e:69ab with SMTP id 2adb3069b0e04-59a17d08c20mr4858078e87.10.1766454087534;
        Mon, 22 Dec 2025 17:41:27 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a185d5ea6sm3600776e87.5.2025.12.22.17.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 17:41:27 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 04:41:14 +0300
Message-ID: <20251223014114.2193668-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

Also, I don't understand how mempools help here.

As well as I understand, allocation from mempool is still real allocation
if mempool's own reserve is over.

-- 
Askar Safin

