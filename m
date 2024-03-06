Return-Path: <linux-pm+bounces-4708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5B872E6D
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 06:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D779B25EB4
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F3D531;
	Wed,  6 Mar 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKh6m9nb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001A1B80A
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703180; cv=none; b=gOW3Ql+8GK3CGsAr7AgGODoiMQHMHpupBg5Cx9vfO3FKP/MahfPNCY28xmVW2bsAajMEzly7yOJmk6HIwR2e67S7QEqxEkJQz8LcjMIPBc9DOTbzkLgIUccnb27jgmoxdT+ZwqjdOPpiYP8sGOA+o37qszkYDx37WO4wLWoucl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703180; c=relaxed/simple;
	bh=NPtg5u6shB7HJm+VpcBl+duxc8j3bwh6Dd+pBnp/ENs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPvSxlKDmkT6/hU+m3lZVJ1TcERak4sellkzIA7N9EkJFmBfSnuidIm3SkoPeiskHSxUi/xyf1681b4uhC/kHG1E0hvCr8UWnYdTbZN37O1BAoFje3nKvEYqBakvBGSJ684vpdU6rqocE45seRKT+mGjtfpLXuPbd5QyBAREbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKh6m9nb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc0e5b223eso55385405ad.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Mar 2024 21:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709703178; x=1710307978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsU79jzbblRigvRorhI+92ujcnlpzSVj2T28tfZa5xc=;
        b=jKh6m9nbr8YhHYlAYr+zVm/kfhQekxWT2BP58ENVP5c1w/Tg6gxv5Nf7RJQLsE5qGS
         HIp5rB63sh6nPRUi1qpoqclX3o4NJj3nOTkThbn3F6U/zM9fY8avXkk1Nk45ScUCrB2H
         f5TklfQyjaQsRyUrcNVM6vDW3dJjhaw744tj6KmprTrnZsKpaEOa3VTdGZcyRk4tsjlm
         2qBLtEvKoi9nYGv4cPWGtwxsPD4aogKXXs8RlmP395qY0+l1yyf7MbhuEWqoCLE4gKL9
         KqjsLS4Df6buccUydG/sdCrVi1D2QyVS8H0VJH74Qh3M0u6KmtqvEWPJJD6T1nb/ZG3b
         I5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703178; x=1710307978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsU79jzbblRigvRorhI+92ujcnlpzSVj2T28tfZa5xc=;
        b=WqKVpuPMf63UXVMSBisrpWPUJlZ+QZ08/jcPsZyQt6/p4eOIynP8/DCWCL5BTXJEW/
         1BbUgL1XEAzY0kPJ06Ifw4V/fG/Io8EhPYp1YgeerXmISBnno3Kr47fpPfij9Qwoo69q
         Qrlwz5lZ3U1/3k6Wg6khhSRXJ3PN9v+Ode77UyINYuk8Sr2TyyBK55Nfr5YWl4eNXRNX
         YjRCK42Eip285VxKJSObZflCb57xvobj8FDFjMRqzcsGH4EGDaHE0Xrx2okfLeVeBhJC
         KZfuyt2N4W1wgx3KwlGOC5cfvbx3M2pS5qrxcjWPvK9u+cllIgXU32AXWZjekQrLQbqr
         E0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm7BAsOXi098qbgAMvnysWj61VD302ke1IA0XSUbBJ/cf1ZUIE13B2PG9Jz9UNXXsWk4UyUjIm10Fj4K1Ptx6ZHPoV+MIrr1A=
X-Gm-Message-State: AOJu0Yy18701bLpHXUdk3o3N5R+5MUn4lSEkFz2v/BN0vANyX0q1w4Uh
	F5EVFKzVkqlheyvlq3gDjmH5i5PKVULRuo9I4uidnRBmk/o943okCmrQKx99TSM=
X-Google-Smtp-Source: AGHT+IF14LEVdHjiOwzABEbNGDOy2jdHiI07m2JQM3c2nD6CTbneowRQFBSobR5vG8K/Dil8Hc24Yg==
X-Received: by 2002:a17:902:d58c:b0:1dc:d116:1a3a with SMTP id k12-20020a170902d58c00b001dcd1161a3amr4708936plh.62.1709703178053;
        Tue, 05 Mar 2024 21:32:58 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001dd091cbc4esm5947105plf.181.2024.03.05.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:32:57 -0800 (PST)
Date: Wed, 6 Mar 2024 11:02:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: David Heidelberg <david@ixit.cz>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp: drop maxItems from inner items
Message-ID: <20240306053255.azuybu346fybjwn7@vireshk-i7>
References: <20240304234328.382467-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304234328.382467-1-david@ixit.cz>

On 05-03-24, 00:43, David Heidelberg wrote:
> With recent changes within matrix dimensions calculation,
> dropping maxItems: 1 provides a warning-free run.
> 
> Fixes warning such as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long
> 
> Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  follow-up of https://lore.kernel.org/lkml/20231229191038.247258-1-david@ixit.cz/T/
> 
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index e2f8f7af3cf4..b1bb87c865ed 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -57,8 +57,6 @@ patternProperties:
>            specific binding.
>          minItems: 1
>          maxItems: 32
> -        items:
> -          maxItems: 1
>  
>        opp-microvolt:
>          description: |

Applied. Thanks.

-- 
viresh

