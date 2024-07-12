Return-Path: <linux-pm+bounces-11045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509EA92FC99
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827731C20E25
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C714A4C8;
	Fri, 12 Jul 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQqMHrLK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B41E4A9
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794682; cv=none; b=XQKPHu8a5d2bs2HAhe2HwjI5kiJ39FA86/6Tty9JGb/Pkq53vaMk4gfVMDqUXp7T9aKP0WNeM9PcrngwPXgCBjTGgEyIuiJyZhZJvoqApsPcjXKQE7c6hCPSXIqcEynhC/FzYTWRYiN2ScTbtU3uX9+/BYPVQ5E66MaYKf7SHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794682; c=relaxed/simple;
	bh=sZjcOuyq7OsCtOyuMDNuT3CO7TIB9jmCIzv9tMbY6Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEWpytt2iJUpZFUn9tuT58jFMcyz842mukJZuwhy6hy3uo4nVk6fq06Px3KZ2KCbo1euVLYUthNUFnacu32HyZyjN4NLnZGfdSUbVXmVQps1RtoWdPA7dEiFAD/6/BoVVF8wXE99UpZ63aaqFiQ6hElF30f13W7sXdJi8d3uVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQqMHrLK; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65a14a92370so19768017b3.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720794679; x=1721399479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+g12SWAGSwS8dPJorX6fFV2pgmkGfH02IBEmGQt9iI=;
        b=EQqMHrLKPcVwyL0luGJ9RD92VK/i50m5X9krKgX3IIICujC7upSkFvVfTvxYsoTqli
         X3OWT1jS702KczM0uQKz4EDjG6C57HG+mvxN3qU7ZL8O1Jj5cmMgQHq17N1Jn++Yl+7w
         5xrPN1pK6B/YHktKLoM9jLNnFIh51NbUFu0JMBxUiHvZRZS8JYRs2bVWbLGypf35q+P5
         w/+s5La6h/M33mNspfcd4I9L/8lyqKWrknUWNFn9ZRWvcM7oNUV7FL3OeCy6+x/j3LP9
         dbFjWMhQ/NZOIBa2Pp4XbAjpgj0VRijkbbRVAd86To0aZhVWluI02+gRWnE3Iat8CdAn
         QbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794679; x=1721399479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+g12SWAGSwS8dPJorX6fFV2pgmkGfH02IBEmGQt9iI=;
        b=WOmugl9DccMHu4ksms4dx7bG09+S+w8/+hOjeVKStPQPA3xneehDIevA1caZ+k1LCf
         +S0ETMWq1gtCycHdubRNKlR2r7niRFLWBn04B0Maq3bRJRNA2UzsHK/xCNcY1Jr7yTHW
         1yN3XdIqFt3n5mQ+BFGSN5zjTwNXFUyrXxF2YCfSvV2R2q4xJQK4U+xWxwZeyIifydyt
         B+lBDR98DHS0jKYUYsHsaJPrDzYWWNuVQN4q4ruUJB2wqundyqsma5Tn9L2W3kjw82Qv
         43ActLGQUB7HWE70cwhFOooBSkq8IYInTV9wZxM8oZ0ErQtTT7x48KxjTQG1CcyCTTNI
         WRfA==
X-Gm-Message-State: AOJu0YxGzpqXZotTH52aiBNxHM2rvBkWPHJAr2PxFTkN/ihFfSr0Ya/U
	VpG6FTi9LIKhRyHulW54pNbpHbUfb3i1jWiECErjqohNRiHBKTNCCcL9o3NpQ+vd92A7m2IOEAH
	U9cbFBZGJafmCcQjn0chGLor9fc/0NL/Uw8KJW1U3OWYCXd43MPY=
X-Google-Smtp-Source: AGHT+IHVUBNaBMmLD5l+bwQG0bNG9y4GUK/Zbtwsv3XwChDOiXIVP/yYe89GvHhiHfx6gAL1RXRYxUWzTKMIy5yCMQw=
X-Received: by 2002:a05:690c:6d0e:b0:648:3c1d:36d6 with SMTP id
 00721157ae682-658ee7905b4mr159549987b3.10.1720794679534; Fri, 12 Jul 2024
 07:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain>
In-Reply-To: <62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 12 Jul 2024 16:31:08 +0200
Message-ID: <CACMJSetEuy0+=SF6fKto9DTtkQAOt6otyo_vQCSoXQfue+mBsg@mail.gmail.com>
Subject: Re: [bug report] power: sequencing: implement the pwrseq core
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 16:05, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Hello Bartosz Golaszewski,
>
> Commit 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> from Jun 5, 2024 (linux-next), leads to the following Smatch static
> checker warning:
>
>         drivers/power/sequencing/core.c:435 pwrseq_do_setup_targets()
>         error: 'target->unit' dereferencing possible ERR_PTR()
>
> drivers/power/sequencing/core.c
>     412 static int pwrseq_do_setup_targets(const struct pwrseq_target_data **data,
>     413                                    struct pwrseq_device *pwrseq,
>     414                                    struct radix_tree_root *processed_units)
>     415 {
>     416         const struct pwrseq_target_data *pos;
>     417         struct pwrseq_target *target;
>     418         int ret, i;
>     419
>     420         for (i = 0; data[i]; i++) {
>     421                 pos = data[i];
>     422
>     423                 ret = pwrseq_check_target_deps(pos);
>     424                 if (ret)
>     425                         return ret;
>     426
>     427                 target = pwrseq_target_new(pos);
>     428                 if (!target)
>     429                         return -ENOMEM;
>     430
>     431                 target->unit = pwrseq_unit_setup(pos->unit, &pwrseq->units,
>     432                                                  processed_units);
>     433                 if (IS_ERR(target->unit)) {
>     434                         ret = PTR_ERR(target->unit);
> --> 435                         pwrseq_target_free(target);
>
> We can't pass this target->unit to pwrseq_target_free() or it results in an
> error pointer dereference.

Actually it's more like pwrseq_unit_put() should check if unit is NULL
before calling kref_put().

I'll send a patch.

Bart

>
>     436                         return ret;
>     437                 }
>     438
>     439                 list_add_tail(&target->list, &pwrseq->targets);
>     440         }
>     441
>     442         return 0;
>     443 }
>
> regards,
> dan carpenter

