Return-Path: <linux-pm+bounces-37193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FF0C2588A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 259264F0279
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99026FA60;
	Fri, 31 Oct 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvs9D7Wi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4F26B764
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920359; cv=none; b=XC1hQrD7D80kxhapp0K7YJ8hMOazmw/geY8KaEy2b7lMvKm0QG3rMqWq+bxO5Qd69RvYggYRm5XVk8ruLF4Nr+ifXUIMHdhNRZvAce5HkkmVquXnZrDHLhnmvD4qp+CyjpxyaUqeXPgu1nLYd137b4C+mZH2lbtCjW5U8LbKlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920359; c=relaxed/simple;
	bh=iGjNEcgSl7MepN7bm0rUsoKrnV07Xn8Pykv00LshL7I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY8r/v+12G1GtnL/Q9t/o2Dg60xDbyhgXNtXGanJEZc21cXUOIEvo0RaNXlOhGQb1mJY1A3L6ImCevWocnJQsNxNPbhVZCq0fMaiIKUo/5rmGQEwC5kqnhM1Sz72HxwOMZ0eAeuu8t5g3guGPuO340+SCgZre2rR9DdiIuI1gYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvs9D7Wi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso30296035e9.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920356; x=1762525156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jUnrqbgsEEeKUxRlK+hEtgof0sdFkQGSEV+8c+8Tuqg=;
        b=Gvs9D7Wif27p25uh5x6+0M/GUXkHG83rISjk5XoM6Oo3Wbt+9mNotovP9l2LvqoJoQ
         NpSgGlR6maj6HqmQuPhiI0wJEhjmC2tomLKGAOUr95++kxhzln//lrQPDw1myqJYOj/S
         aOoi7nSpNqe2JnBw2rkPCiSY/AzGRzGrlG0uQJnv1fqjQ1HMtj36fM7vxhjXKhEyPawE
         vH0oat5s33htF33eStVd0rWiz2f+XDPEqz9lb9oh2CwQlmNmDUV4wTsQRxfnm/98Tjj1
         If0ZfRPFlw42nwFydDTJYaVxB2AkRJlhYOV/ldsWcJIDojBCm2qwER+EVEDN9jOYSCGU
         QIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920356; x=1762525156;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUnrqbgsEEeKUxRlK+hEtgof0sdFkQGSEV+8c+8Tuqg=;
        b=r0si+zrO0SXzicQWDA+xEQvaGheNq1+wRSkAlYs6NbLxBpSl0i1YNKCp8Bl9TbSSlJ
         j8D3RRrYuCMnHgeHy/qV7N3h+ZJM9OBqJno/rwlHciAjOu1iVNALME2ZU85NSdlrBv59
         aGSlvLvAqBe4rbbu5t6gkYDy1yYkdfXV0DgxjDSyE+tDyq4O8n4FnoUcmM8LZM9t+hE0
         PK8fwZoI5ZWcdhpR5sSwN1E8kBRPgisq061FCoWMv+ZnZFw25mcn1VoNpz4v0vveC3kT
         6monP4btUMjHiNK4Jhhx03ekE8HEYeUZWEgc3xOXNfRS9h4I3ZgW7aphQnOOQNHgdpIV
         +LCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/qOpohA7VBSr5/T2QLwDYYSki/JA1ksriBbfHOSQKNYGugMBcaBFS8b0tn8kMA3/JF/WzNUxYiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSjM8Odiq5I8FFkoxiJQsscooqaTTnXXo5RkaVm2tjyvjdkzi
	NmtezMKCrZbwu7ijX1Z31sY6gZfQkKrk+JWQ6iueI4spKQX7oLfeah0c
X-Gm-Gg: ASbGncvGG4NmIy/AC8bsOiFBmS9zqKFibDdHU397jGgGqDpwT4N7aTGWEGfe/3BlZBB
	Z3MyxThgZZZNV2Mzbx0r2+Zhx1Y2RHJPExvCA8N7raLWRoNqrnvCfhB4IeiqsyTxjCf/zgzm5aW
	Bj7e2u6OwfXmAUMHAS+JlediS0DK5Lhlr9yOcZ+0TmkESIJUEiQtFMtg56yy4rAW3pSwUCr1xXw
	UCCNIz0RG8KGcsPFLxmvbNp3GTZXk7KvUsMZnTYloOOD/bDdn3rLfY2xkuXmAvDRkKK7DJEtRVp
	LMl0fVcpP6IjnV6ABbjzk+0JRgO0NRXFLtz4zVpYlNN0itIoerUUmqXxWa4JP52cN4ZJI/RO6wW
	LgSmh1AUa7kHpMqgaGuxj0HSTn/BoPTdBH/jKL4z3W3slIhnzG0dZy0aFhSUbHxvwPgld/q/SjG
	xxfX6p5mi50WLloNAxjeRytaVJfnLQ
X-Google-Smtp-Source: AGHT+IHE5UpyXRgf2wW/MhlT/KO5g75XTHgiswzIr/CP1ChliZ7xkOs9eo0r7gde+zfRghiWxu3xQQ==
X-Received: by 2002:a05:600c:820f:b0:477:a58:2d6b with SMTP id 5b1f17b1804b1-47730802d3amr36677275e9.7.1761920355393;
        Fri, 31 Oct 2025 07:19:15 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c3243c6sm301615e9.11.2025.10.31.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:19:15 -0700 (PDT)
Message-ID: <6904c563.050a0220.a13ee.0212@mx.google.com>
X-Google-Original-Message-ID: <aQTFYFixlQSHRWo3@Ansuel-XPS.>
Date: Fri, 31 Oct 2025 15:19:12 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <aQS5FpuOWk1bWnQd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQS5FpuOWk1bWnQd@smile.fi.intel.com>

On Fri, Oct 31, 2025 at 03:26:46PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> > On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> > case for some Google devices (the OnHub family) that can't make use of
> > SMEM to detect the SoC ID.
> > 
> > To handle these specific case, check if the SMEM is not initialized (by
> > checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> > OF machine compatible checking to identify the SoC variant.
> > 
> > Notice that the checking order is important as the machine compatible
> > are normally defined with the specific one following the generic SoC
> > (for example compatible = "qcom,ipq8065", "qcom,ipq8064").
> 
> ...
> 
> > +		if (of_machine_is_compatible("qcom,ipq8062"))
> > +			msm_id = QCOM_ID_IPQ8062;
> > +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > +			 of_machine_is_compatible("qcom,ipq8069"))
> > +			msm_id = QCOM_ID_IPQ8065;
> > +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > +			 of_machine_is_compatible("qcom,ipq8066") ||
> > +			 of_machine_is_compatible("qcom,ipq8068"))
> > +			msm_id = QCOM_ID_IPQ8064;
> 
> A nit-pick (in case you need a new version of the series): I would expect
> the conditionals be sorted by assigned value.
> 
> 		if (of_machine_is_compatible("qcom,ipq8062"))
> 			msm_id = QCOM_ID_IPQ8062;
> 		else if (of_machine_is_compatible("qcom,ipq8064") ||
> 			 of_machine_is_compatible("qcom,ipq8066") ||
> 			 of_machine_is_compatible("qcom,ipq8068"))
> 			msm_id = QCOM_ID_IPQ8064;
> 		else if (of_machine_is_compatible("qcom,ipq8065") ||
> 			 of_machine_is_compatible("qcom,ipq8069"))
> 			msm_id = QCOM_ID_IPQ8065;
>

Hi as said in the commit, parsing 65/69 before 64 is needed as we might
have compatible like

"qcom,ipq8065","qcom,ipq8064" so we might incorrectly parse msm_id
ipq8064.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

