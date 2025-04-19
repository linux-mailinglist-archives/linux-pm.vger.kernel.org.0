Return-Path: <linux-pm+bounces-25742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E14A9422F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52587A8A82
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A683E198E76;
	Sat, 19 Apr 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxoB3G1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE65CDF1
	for <linux-pm@vger.kernel.org>; Sat, 19 Apr 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745049292; cv=none; b=jwCbHzNRmBTNVh1xwWCQA80wCt40ILdmRTa/pC9SJnEYoBzN+9TKM3dFK8mdn8Pl4LrOfcnOc0sasXBJcvBinILPeXjgL6U4Oe308U1TaDrfsoNKEnJkoxWex4brWR0a1/PNQ5xC6Q1mKT3hMvIrrUOGs5b0ZDQHNOdr0aSw0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745049292; c=relaxed/simple;
	bh=LUxbgbJ5oVx1nAwshmTPPLRQRILWjjmsG7cdfT1j6Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaoZTW21ivsFNr17Im+N6yzWT9K+4w45SK90159Y2DtejGjeAM3cb8OHOce/IFcYhC7c2hCV8S6stmf/sOR93Gsgcrtanind6yQCIS7IlaGKh34w7bFzaIqu+yPeo+oDO5ZmDtrOcZ7BBF7Zv2696VhxclAKVfWdeEd5S1gU9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FxoB3G1U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so4819375a12.1
        for <linux-pm@vger.kernel.org>; Sat, 19 Apr 2025 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745049289; x=1745654089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zb1bzIRjEgSOs4CWP1wIyg4geR/sfLMqOdhecmna95s=;
        b=FxoB3G1U8+9MEviwUsZUwnhcd9GGre40YPkm+zlgIDFokdJm0v6JjDbhtp82sIoreL
         qw4kS7QUw6r0ikuamCdEM2vx1Am6r9Yl7YBieSrXmEYvYHEGJxgXtIuIAF2p+0rEmeLV
         ay6XuB0oN8N5IM/xhnD3pQqKAmC0Qf6ecSIqildz008GRC22UkaP2Rjcdm4lksx2ZBEN
         ahLbVjfDfFciD3oelhv42cZZyxar4Tg4+xDG8jUVQrgW+/LzTaKYbA+0XB1BVjKyZ3XT
         rThnnW68DHpnfmiGD0TojVt826QIzlEVEqLKk54nT5GcQEor+X61toC3VMwKzvKtpExc
         Jf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745049289; x=1745654089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb1bzIRjEgSOs4CWP1wIyg4geR/sfLMqOdhecmna95s=;
        b=A/Np9fxpRHkMgywkxBdKTwd4sVxhQ2H4uY0tZ6xvUKP4PMTkJ4nW0sBubEgiK15cv0
         qcWmxP7lvzRyvc1DXdz9WcHgfYKCext0xSLACPax9O3LZe3QVMGyNWERAMdhie6SHKmW
         KPtS1Rp+tRWVwYEuj0GBpONOVWXy789O0gCKY9PBk5qUMyErKTFYCZ+Mdz48coEjMrGl
         cytQsjClOvA6axjcklZYbV0wtne0wljrJUg2XKHGWwJ1eVE/ti6j1eMutJuoYLXa6hYZ
         yhQ71QjheW4emd5Is/Ea/fW0bk1DQR8h4CWm6AKgm4PpM8AGPu/pTaKndnEEOrC89oYV
         ouTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM8wNOzG7zFz5lL4Z/Q0eGYuoTKG0vzdw2+E2zvGTc0GAhTu2Vg6t1CH3X4/CUt/89K1OiwEF9BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlSo2iCyENxWGWsPe8VyrcoCICMTsm+THWZFoT2C0j/l/DGeS
	EZPHT3YJoPvJCi3wZtJx02o0WfexwfmjzQlMjgk3Nsl/mF4Q2aceGsRAPl8gZwdJhErqvswPUA1
	N6VY11YM9GgfeMTAcL4+gfq7HAnvzGioUC7hqrA==
X-Gm-Gg: ASbGncu94/lXwOS02yYNZY8eu68Ag28KtXAUM0mJPeQHxMh5F2/RguVgtEtIiRUojU1
	rWTIobR3R/UT1R5YP5YitVYIfM42pptmR3vT+P79zFW4Mb5rhKCK3Efc6SLMbplKMWpibCHNnCS
	xvEu4EOVmJYsdks+E2UFjMZA==
X-Google-Smtp-Source: AGHT+IGwRNWU0rrwUfT4SLBMOGrqTvfLE5G5jO68k1EuN6yuzFM6vTtch0N2rxVxCh6x+MWj8oc4IU/P86M4a/GNVLU=
X-Received: by 2002:a17:907:743:b0:acb:6746:8760 with SMTP id
 a640c23a62f3a-acb74d9a786mr476426266b.47.1745049289112; Sat, 19 Apr 2025
 00:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com> <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7> <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com> <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Sat, 19 Apr 2025 13:24:38 +0530
X-Gm-Features: ATxdqUGTlqtgOT3m9t68FvMqcpoTJ9KYkwTuyPbedz-dsKJP3aFcvLxz2dDkxKs
Message-ID: <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:58, Rafael J. Wysocki <rafael@kernel.org> wrote:

> So it updates policy->boost_enabled in accordance with the current
> setting in the MSR.

Yes.

> IMO it would be better to update the MSR in accordance with
> policy->boost_enabled or users may get confused if their boost
> settings change after a suspend-resume cycle.  Or have I got lost
> completely?

I wrote this patch based on the sync that happens at the end of
cpufreq_online():

        /* Let the per-policy boost flag mirror the cpufreq_driver
boost during init */
        if (cpufreq_driver->set_boost && policy->boost_supported &&
            policy->boost_enabled != cpufreq_boost_enabled()) {
                policy->boost_enabled = cpufreq_boost_enabled();
                ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
                if (ret) {
                        /* If the set_boost fails, the online
operation is not affected */
                        pr_info("%s: CPU%d: Cannot %s BOOST\n",
__func__, policy->cpu,
                                str_enable_disable(policy->boost_enabled));
                        policy->boost_enabled = !policy->boost_enabled;
                }
        }

So my patch works as the cpufreq core force-syncs the state at init
(pretty much what the driver was doing before).

Though I now wonder if this code (in cpufreq_online()) is really doing
the right thing or not. So if global boost is enabled before suspend with
policy boost being disabled, the policy boost will be enabled on resume.

--
Viresh

