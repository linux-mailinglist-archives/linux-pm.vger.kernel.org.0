Return-Path: <linux-pm+bounces-38191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28708C6BC19
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 22:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DECE4364E05
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2830DEC4;
	Tue, 18 Nov 2025 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN/JSCS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6F3093B6
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502365; cv=none; b=AYf9O2tv2jdUiBUkrX78M4hVRde4/+l4SQ6ELlAZkJMBYfjU1/HcxWAImS6/OUjHNAiYZty3uoybzolJA3lf38C981K84u8sGt7i/hLtWNLkh7sDtr+Gc3J5+SzZU5utVBtMV5gMpUtv8+p7vByhSS/J6F6wqbMl8drgY0A/AUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502365; c=relaxed/simple;
	bh=Wo8abE6ZwL+tRt6K99TsN3lhFcsxaPkTDTphM2Uknig=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5Hr5EAUjltYfqLR5ZtZCmCz//HHHyJysRPYaNg4Ume01EBMpv/xwLWIYYyMI7P5MAIkfRMnll33vPVNxenVrawNbJeJ3qrRpVNn0h6YOw3lhVxmm67vKlcISA1Eh4CaQglHtqEyMVe+eNoOEJvqIlzfIuuTd7Vn1P7EN4svfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN/JSCS/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c7869704so4515683f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 13:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763502362; x=1764107162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+PmSkorrHjrkaGRDS83/mqkWmQ5DIqrE7u3ttoJGMyo=;
        b=iN/JSCS/PK107cYr+S4Re4SmFn0GTrejlNWrePoXgvAqdJ5A3oBDqV89gxZWF335sC
         1UWFBqe78gys9f+z3b4030dTKgmA4Sej/iYT4xbagtUPZ2y/SoI1uwqXETXzqmT81TSL
         2/1nqD9XuTLxqMEvh/8eiTnBq26PZJfxfsGApLKGDCwjFwMD2+9nCKaPlIHYIqhdIri9
         4zVFH3iEwUZn7S5TJevKlmcTfg5C7SSC/P4mGCSydSUR710UBMbUNqKHof7+rGEszGik
         G6hQUP7PTNA30m7M+486ff4X4Nc9WKWp5+wsw0DWZnbxEMyCTNgbXcAa+Z4bj8eju3RV
         jByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763502362; x=1764107162;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PmSkorrHjrkaGRDS83/mqkWmQ5DIqrE7u3ttoJGMyo=;
        b=q8RiPNC7N4ImdMbI2oobM/7zAz0+WhrEol512vTjyyD11yX1g5SJ/bHb3p5z00OQbp
         0lQAkQZjRMOt0p25gkWtgGSqunMlVrV2WJzAPzbBbilsYy9dKzxDyCJhzfVDIhPACHKC
         quNb54le4DSafsGzDekbQ28fWpH0c8QxhqRvxRpZnpd3M3vcr8cmkEviUml+mfHbrH7l
         uxAfSd5LWkvTbb28YKZCrKCSBqFVqUmMImx95OVYEnNHc198at+R/DCrFn7lZVGhbfr0
         OIFBMFF7QYdyDDLjeXrpyUCc+KJ0PePboAJpbz/WKA3SzTWBUf2nt1fvqVBYDTtRF9Iz
         NwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0RQZ6+liKqyoWX4kdAzJ3JcopS/lt7oughsmmvJfHmdx4EWopAv8b7hoSvmmAksp6l+vl7/OhWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAoOELFmP9q/NiAu1IA1JjeJRxb64t1KAfghArNYUm39zJ0m+
	oAKl2KOlLHSSf+rnEj8daiVjN+tqap243YK2Ua2LjfiZP7Oa8PEM8pv7
X-Gm-Gg: ASbGncvDDHRaGtA//lt15hIrNtqgI6908K7Bq8OfQU4ddshZIpO7EPEsZL4VtE39n4a
	Vax3FLL2sjjApof1RzLBl0c64qYqCCk8bYgIk4/TvsiZAXhWpBxkn/oXHr+i4nqXVZzuo8oMu0x
	RqVEKftlVlI9FaC/LrUjBbdV7ad3eSiZuBnbYkkxWEvnj/gUMUBO1vgPq3ScQ3Yn7ZzMrYbkUMG
	mMvJRXL2ZDaJN3I6paQrV7QLYfHE3b6NsQfCyiDY8ksZEz7XfGa/sHaxy7hx0J1BWNyTR5t3+/L
	KtlGErcq6/FizzyGVbIWMtjB/bUJ65KWXLxf+pQW9aq56+2FXThgaOnEHlxB+ao7HoZs04R1j6Q
	neqkJUK0C0bk+T7ERomHCMCKl1Ci4WnJJAcQrhZqn+F2sA5ltjP6HI5noItaVaZ/xuQOebscTLs
	UXajkMEkVPy4iJh+TQE1QFZIDbKRs5+JwfrPrnVAF8La7h3l/yqQ==
X-Google-Smtp-Source: AGHT+IF6uCuhtwJUtOmpyrnNZmNwcuvn6wN8ul9YQfSdxaLj265T7WGRIxVE7tN5RTMZ9/AF3aUO/Q==
X-Received: by 2002:a05:6000:1788:b0:42b:4139:577b with SMTP id ffacd0b85a97d-42b5938fe6dmr17006240f8f.45.1763502362082;
        Tue, 18 Nov 2025 13:46:02 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm34944300f8f.39.2025.11.18.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:46:01 -0800 (PST)
Message-ID: <691ce919.5d0a0220.811e.f1c0@mx.google.com>
X-Google-Original-Message-ID: <aRzpF-vTSRA1gOPe@Ansuel-XPS.>
Date: Tue, 18 Nov 2025 22:45:59 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251105112136.371376-1-ansuelsmth@gmail.com>
 <20251105112136.371376-2-ansuelsmth@gmail.com>
 <20251118191018.GA3997357-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118191018.GA3997357-robh@kernel.org>

On Tue, Nov 18, 2025 at 01:10:18PM -0600, Rob Herring wrote:
> On Wed, Nov 05, 2025 at 12:21:34PM +0100, Christian Marangi wrote:
> > On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> > case for some Google devices (the OnHub family) that can't make use of
> > SMEM to detect the SoC ID (and socinfo can't be used either as it does
> > depends on SMEM presence).
> > 
> > To handle these specific case, check if the SMEM is not initialized (by
> > checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> > OF machine compatible checking to identify the SoC variant.
> > 
> > Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
> >  1 file changed, 33 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index 3a8ed723a23e..be44a8965e3a 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -252,13 +252,22 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >  	return ret;
> >  }
> >  
> > +static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] = {
> > +	{ .compatible = "qcom,ipq8062", .data = (const void *)QCOM_ID_IPQ8062 },
> > +	{ .compatible = "qcom,ipq8064", .data = (const void *)QCOM_ID_IPQ8064 },
> > +	{ .compatible = "qcom,ipq8065", .data = (const void *)QCOM_ID_IPQ8065 },
> > +	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
> > +	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
> > +	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
> 
> These are all undocumented:
> 
> qcom,ipq8062
> qcom,ipq8066
> qcom,ipq8068
> qcom,ipq8069
> 

Hi Rob,

you are right, I never add these as there weren't any dts for it. I will
send a Documentation patch ASAP.

-- 
	Ansuel

