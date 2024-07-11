Return-Path: <linux-pm+bounces-10994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686192E8D9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CB8283C45
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2A15ECD2;
	Thu, 11 Jul 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h78k90H6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170115E5CD
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703000; cv=none; b=DZz/PXBhgq0C0Cp7/i3eg5OORWZ6kyPnN4C23nxeO2EKOm1hZBAWXYaX21dtbrTnigJGT+IG05da3iIOVlvvEfuL0tTSV+QS6doV8HaMuTLLHrjLroH9IZHlrRQpAAfe1V0B0fQBD8F3Ja8zDqJRnVx3+VuyA4wWihu+nP69U3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703000; c=relaxed/simple;
	bh=SBDpIrGkZi9GohGzDpxipP4345aWgfJ+YlCcPQWVD2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRlOPkLLD7Rmhgzo7nlgPzRlIDiaIGfXhTX4aVTos10yRCgE1Sb7gsDImXKl/E6/be87j/mZxibtrSo0Kffr6Ahx8bQTTe039Fc2o59LhtPpZSMI95juHapUfCEOfDMTAS+hIXAJXIktmTr6wZX8YoqpEj0KXjaXleFcmKeTWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h78k90H6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso740047b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720702999; x=1721307799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1SxUF24cDENdKat6hTnnuDpRbvWXonwGbP4sPkAVso=;
        b=h78k90H6Brzz7ai/Fv5fEl/LByCyDYIBvdgJaxOdzeGXJH4u6cA1GnViVodufPemRU
         yGSFhw6qrFGn2wun/T/CjS27fLv8ydb5VBLb2crYh4XzM1qWDqUuyWOUpGsKngICSarg
         +vFqHAHd6VweQxNWlSsHNwsMMrpa7AZd553W1IeB9R70xpdlFSrU8gVhwOhQ0m/+McXV
         mNGrz3tA5d4q6f/8J9u6WceQr2ooyUDvaQjq/9XrY/kfythH+B0z6OIbhUgUQUL6vKoF
         Iuh6qIAXlRai4X+bxpBf4k7HrXVhpznqQ67v4qM2srUs6UCQctKslegVgsxM77bg/qkl
         fQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720702999; x=1721307799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1SxUF24cDENdKat6hTnnuDpRbvWXonwGbP4sPkAVso=;
        b=Tbv0Ia1C0ldnxW7tZS41TN3d9/VLKpHZ+EiRsG/7RAwi+wG/664oj5PUPOgIKqEvOY
         3jibzJ69M3OTYNmZGRukgqt2LZ87NZm1RfALQFo29llni4GXnkRhmtciW7bR8+dnF6kr
         ezRmFUKW46mtBl41uYINSdF7ZyvMDMKi3PzLHwl7u5DNojfjHiauaHM0uihei9YnFuRB
         0zCFw8SziMMQkokoOLrLRPrrhrUW9b0StMwLgzzat8RIcCekms1e41MS84iP0GFtOCjL
         8qYatoeby7eCqLYA78zSY3BjcwYy/FYHEujKR6tpPiuXCVsSh3dnhwmVyDq0cpZ2wC0m
         MY4A==
X-Forwarded-Encrypted: i=1; AJvYcCXxXsvD8qp8WQ58NIH/sgYHxKN+HHR1zTEm9F5FZR0u+Lu388GfNZjaPLgWyypcveMQJ9KF6R38hi2BQB176k5O5IXkQ6mI6y8=
X-Gm-Message-State: AOJu0Yzxyrd7IWjRqD0Ks3v6tuGHHssIJigCXXMcslcqn72eYJkirmUw
	v1ZZlO9GPDTRDe7ZAWLfyNdnyapI5x53DtGK9HJnbFjiWYfgnCYR6jMuJVGmuTs=
X-Google-Smtp-Source: AGHT+IE+Rg45KLtzV1rOkgfVccRuVcNyr5UkUNEO3KxLYDkqocrAhzDcexwNdPD8SjaKk66mW7pEfA==
X-Received: by 2002:a05:6a00:845:b0:705:a7a6:6d11 with SMTP id d2e1a72fcca58-70b435ed145mr9569333b3a.24.1720702998413;
        Thu, 11 Jul 2024 06:03:18 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397ee71sm5792853b3a.141.2024.07.11.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:03:17 -0700 (PDT)
Date: Thu, 11 Jul 2024 18:33:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] OPP: Rework _set_required_devs() to manage a single
 device per call
Message-ID: <20240711130315.6xxlb53l5sd2cxwx@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-4-ulf.hansson@linaro.org>
 <20240626063321.3x4cvyj7yiks5f3p@vireshk-i7>
 <CAPDyKFqY_mNnaT8j4vCXxYtARkGb_bkvcwKkyXcLPwW+gutO8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqY_mNnaT8j4vCXxYtARkGb_bkvcwKkyXcLPwW+gutO8Q@mail.gmail.com>

On 11-07-24, 12:19, Ulf Hansson wrote:
> Unless I am mistaken, I don't think that is a scenario we should care
> about here.
> 
> _opp_set_required_dev() is being called for a device that is about to
> be attached to its corresponding genpd.
> 
> Yes, in some cases, we attach a genpd provider's device to its
> genpd-parent, but that is not to control the required-opps.

I understand and I am okay with what you are suggesting, we can fix it later on
if required anyway.

But just to give my reasoning behind that is that we want to avoid a very
specific case here and allow everything else. The special case being genpd
propagation, so I would normally not do a blanket ban but just that case.

But as I said, its okay :)

-- 
viresh

