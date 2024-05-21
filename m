Return-Path: <linux-pm+bounces-8028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1308CB18D
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB701C218F1
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA4147C65;
	Tue, 21 May 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWV+HWXq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200A78289
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306053; cv=none; b=exO21BFQgIWVU40ALrQNlF7wxdFotV2B/RY32PzNq39hzX+SVls+0aoWuRSCZAakB98lHbTzwMjvv0jRwKKma/EuVlH/r/b1ZSP2gkSlXWX1Xo9XzW4YZjVO5UD8sa1n72pYGAdjEbiT/thYAAIOupL80wnjL+VbDiywwS+5XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306053; c=relaxed/simple;
	bh=fh4ig79HR1T76cXxQIw68f9i8vKVHSI4DF+AT4HSAvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABZhyWjFJqXgEVW/01uPhW7ST9OQJKgUYBBGLbH5KLS+1SyqI4BDpje4rF5pKvCsFdkT0S87/A1lYrxeLPyncW0bzJxTuHXxhiLB3XOST4CZZ/bNG3KjggfLQ+6fXP1gHjL3xbjGk84v5SYpJfKxx5Xf4Xs6IFQBnQsBnBqGyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWV+HWXq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee12baa01cso2549355ad.0
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716306051; x=1716910851; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UnGp/6vXmo6P9YdxT3N0iSjGrqp9ypanfUO389parWM=;
        b=NWV+HWXq94Hj+BdKIWp9PHd4tTjRD70t1pB6UbfT3PTOI4rps3GseYiO7+Zcqgr4cN
         OEbkJHTTthWBTckgptIFGRxtO9gR5jh4QT45HiwpQGJkQXpjCmC0gBoj6MhBuVniGExW
         bvDh8BQjjiGWQtGSZwGBmQ5wSn9X4Wj29LZgPJcgHUowh3G244hmTvY4uWKPYLOGbW8F
         mxGPX+vgq8VTNsZJ/1p/k/rwWK/piFQCKbBr1BjsgfiZ/PgVT/PkiE3yyuzKfdZZ6Lf4
         BMhP66IjIb9gsq0cNeHwJJlgpZWyBFoJHbUwQtdm10MjOgJslWhLaPjEXBSvatJHWOMx
         M8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306051; x=1716910851;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnGp/6vXmo6P9YdxT3N0iSjGrqp9ypanfUO389parWM=;
        b=Oj0LcRm3NOnQf12eqrAY27hRuPDY+2PQmUHVkFbV2xoZ7Q7J8kBzobunG6xe4oH7Ey
         PgEoY2BwlsXV9Dx5bjEMmUkzUU8efEqeoQOxJtaov1cfnbvxfSGlI2N5fsR74NvizDY3
         W5UohQ3PLSMepLjxIGQGKUo0MfqNeLd8Z6jH7didf0R87swDp//tivwUktt8wlHQckmb
         OeDiZeqfwEqx+Omfzpz9k5Ygm1+ISU74yqSZ/1PH/RJN35PmAjS7Aurp6WS9vdw2w1nw
         ZzxaWtljveu1d/2ONeN19aHBGAFA/Bl91sEXq+slbA0eQcBunQm7p/NHsH7B70aPZl94
         6zzA==
X-Gm-Message-State: AOJu0YzG6O486L9cmkrUThVhqJ9ZkroGL8wrOIaFXBdpAyPkNVAfCgGD
	fj/gmHFYpA8qiChxUzKiiJMNnWXLm/eho8RTZpk/kzVwwLop6YdL73wTucHzsoaTqVBlb6YmvrM
	=
X-Google-Smtp-Source: AGHT+IE9/qgHxCwJ5baP+tq0PBH7jNC0Om4uR0u7EW8DhYJ84nxKi+8zRggB20Mj87yIx2tNDjJ78Q==
X-Received: by 2002:a17:902:ec81:b0:1f3:6b0:e64d with SMTP id d9443c01a7336-1f306b0ea4amr57996135ad.67.1716306050972;
        Tue, 21 May 2024 08:40:50 -0700 (PDT)
Received: from thinkpad ([120.60.74.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3083e6bb7sm27879935ad.164.2024.05.21.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:40:50 -0700 (PDT)
Date: Tue, 21 May 2024 21:10:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	"linux-pci@vger.kernel.org Bjorn Helgaas" <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Subject: Re: Behavior of the PM framework w.r.t the parent-child relationship
Message-ID: <20240521154036.GA59482@thinkpad>
References: <c0c9fd70-69d4-a7dc-8c4a-773dc742f6c8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0c9fd70-69d4-a7dc-8c4a-773dc742f6c8@quicinc.com>

+ linux-pci

On Mon, Apr 22, 2024 at 03:30:18PM +0530, Krishna Chaitanya Chundru wrote:
> Hi Rafael,
> 
> We are planning to add runtime PM support to the PCIe controller driver
> and facing some issues with runtime PM. These are the details.
> 
> PCIe controller is a parent of the PCIe bridge dev node and PCIe
> endpoint driver as shown below
> 
> PCIe controller(Top level parent & parent of host bridge)
>                         |
>                         v
>         PCIe Host bridge(Parent of PCI-PCI bridge driver)
>                         |
>                         v
>         PCI-PCI bridge(Parent of endpoint driver)
>                         |
>                         v
>                PCIe endpoint driver
> 
> There is no driver associated with the PCIe Host bridge device node.
> And the runtime pm for the bridge node is not enabled explicitly.
> 
> we are seeing PCIe controller driver is getting runtime suspended even
> when the PCI-PCI bridge and PCIe endpoint driver are active.
> Our expectation is controller driver runtime suspend will be called only
> when the child drivers went to the runtime suspend as the controller
> is parent device.
> 
> For the things to work properly we are calling pm_runtime_set_active() &
> pm_runtime_enable() in [1]
> 
> As bridge device node doesn't have driver associated and it is kind of
> integrated with the controller, So we are expecting when the controller
> driver enables its runtime pm it should enable the bridge runtime pm
> also and vice versa.
> 
> Can you please check this behavior and see if it is something which
> needs to be fixed at the PM framework.
> 

Hi Rafael,

Gentle ping on this thread!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

