Return-Path: <linux-pm+bounces-10019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E61917915
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4945B1C217CB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9114D458;
	Wed, 26 Jun 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RD8uZLf9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688313CFBC
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383853; cv=none; b=JwiSKbzj3XwvuPoIrIlhAr5+pPfZOWVHYTCfy7CT2HBtJRyety3545K4kR9vSlu5TblDr/qtYlqOdGw/MFGgjdrDL2tptECMevEQraFhnAjkCPiAI8fWaqMe/0Qopnp1cIxhc2t9FeaztGgmLKLbsKJAbikBHagi8Y8ctIIuLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383853; c=relaxed/simple;
	bh=WjHIinQIPpgmVadzaOYL2FN1a05qHYAYurKuBSI9Ubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAOXV6u5j1kKLLIFrGOnacv1yLrQuVD6pzmdZKkSxfFwRUMUhwrWCH4dgFONAzFeLwwqE559tTK+mBHcKnfCn3lODgW9TToRsKwwhg8UCWAUU13L+EsDSJvaxUdgjOEl4uAYZzMHX9iSTPt6oRjr/pgR56ZQGoV2zUeLIpuy6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RD8uZLf9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6fabe9da3so51743415ad.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719383851; x=1719988651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WmbxbHO00C4vKFOsHsy0MXpWKHaZIqKhcPiT++FQA4=;
        b=RD8uZLf9JrxlCSwyUBYwrU9F6qMHxqWHvW+eQd7TqoAIkZCq3Y1evjLDuekBOa6/+O
         WFhHODjMkNadaHSEYzrDXIA2BY51tVkiZvcd2iupsueVxwm+1qR5Trcqo1JuRZ1aA7Ua
         EgAT5sVR6LcgfHeFNbM+6GJhpP1sKYi8RRCSEP0v9+L5scU85scoEjCYYNPj2TDZRpHJ
         UURgqU9IhYHy73+nZ1fkMzVK+/O3FqmmI7kgJqYQZ4WRK/mknGeWbxpeN8iq1Jna2M3K
         k8zm1QnKNpr5vBDEZcO71BKgaBX+wmZJLGGFGd/2wG7dBu8T20Swlj5Lu6pABlYsJ/BG
         i02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719383851; x=1719988651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WmbxbHO00C4vKFOsHsy0MXpWKHaZIqKhcPiT++FQA4=;
        b=TVtbhefV8kJtMVeK8D5Y0P9pRQjao89xXYa/J+CoHCk+HMoKGUKKmy4aPelbEjDmnb
         hS9dsLoZIdIscJkKZXYfyv7RiDCuRm3UOI3pBrKjLxhSXIvD13dkCNbgrS5GpXQsXJNR
         jC6GrLIyMobTN3ZIS+BOU1CbmnXlteWNj5eF0/gtl4+P6xiYcXKAwLVbYVjyIenI1mIp
         ynJkdNzZzHqfV/WkP4WYHBhNeQf1khShf6/U5EP6gttZv0BClfaIPIuRElqubsHixio4
         p1IX31UCzvLkbHcSdBF64brRhCW4nuJozBgwwPBmR7s6YKC2X3Hxzzvn5jAo3hjhDyk1
         jcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+bvidtJ8ft6mn71ad619/IFm1Yamp8HolMmwbqUbqaYIBgp/uQJzld3TguVmkJ6AJxG+X37H6rivO0JWwczr0KdBmspgaqM=
X-Gm-Message-State: AOJu0Yynyaxavdr9NM/sL7wFphyYcmKB2Ozz6GyHpGGWr4H1wWfk+4+w
	QmxLsDgwDIN/BkeLjRSyCNaDVCHypMZTKWQPaQdOZwnrIXgT68Dw3JK2HRhPylI=
X-Google-Smtp-Source: AGHT+IHPZ/M9X+i2/I7Go5isNU7nO2ti8PIKw/zBI0W44C0AvL2ALmu8+bSPbMXV8uPWpintZOHa7w==
X-Received: by 2002:a17:903:2290:b0:1f6:d81e:d0e with SMTP id d9443c01a7336-1fa23bdc4b0mr110254425ad.5.1719383848988;
        Tue, 25 Jun 2024 23:37:28 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa57a205b7sm38302105ad.112.2024.06.25.23.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:37:28 -0700 (PDT)
Date: Wed, 26 Jun 2024 12:07:26 +0530
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
Subject: Re: [PATCH 6/7] OPP/pmdomain: Set the required_dev for a required
 OPP during genpd attach
Message-ID: <20240626063726.zsnj7iasl4y7ic2d@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-7-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619140849.368580-7-ulf.hansson@linaro.org>

On 19-06-24, 16:08, Ulf Hansson wrote:
> @@ -2393,8 +2392,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>  			const char * const *names, struct device ***virt_devs)

I was expecting that we can get rid of this routine completely and OPP
core won't be required to handle this anymore.

-- 
viresh

