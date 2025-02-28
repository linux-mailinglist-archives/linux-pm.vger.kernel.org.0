Return-Path: <linux-pm+bounces-23152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF74A49140
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10F07A4ECC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DB1C2DB4;
	Fri, 28 Feb 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bv81uUQi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015F1BE87B
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722364; cv=none; b=S4drFhH5H1u9v+dN+a5LjRo2eUOQpSptfNscbUrxKvHZO6IREKTPmTfXlUAaJwMTcMJ2JnvHabzlYHEi55CogG3DepZH41n+DAlNWDEMA2pJwO4sSfgixJtz0GpmE+57Sd6s+WKulJsbiNbrxsFhq+x33obhcWxs939XzWhO3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722364; c=relaxed/simple;
	bh=btPvsDquHHB+QW57XVbJyyust/qFlxWOqT8A+x/aOCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsoJnKZpHJURrxNetR45QNw9otk3aQ92aeJ+Zbd1mnHWs0531NTIAgQ3rqOtUmboc4SyUBzghNEp26Tu5CHfDH0egDqSxt4sTDWiFmM0lbF8hxSKqiSkkZXq10HnXXiBFV9VaMIMmRbotDXHV0s5+yj3Ni9xoW+kjjxzqTtWDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bv81uUQi; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30762598511so18339001fa.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 21:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740722361; x=1741327161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PriYakVb+c1J8nOvCrogaGJFCt/pnunKJ29UwQZ0vI4=;
        b=bv81uUQisnQkP4+Lf4pua3ph3YVU8icPsGQlZZsglZ9i03bobJcQ3+NOZmDJDnhLzs
         wTcpL0JCz8c/zfy5Sk6jSFIw86nIeIsKIwprlvOC55KX3ZulhI882LkoypllX4mwGdHy
         LDKrCrp4B77G8ymNrz63/X0ZlM1MaeeYs3eS1XyRhiMQ49W53ImwPbRourySo/S6Sokc
         fC5cBHmCHbR7RDbJ01ngboUSdXhUDTy20K8kojXA812wO3J3haGqZV37Fb6wl80f2Y43
         i+FSkbiE13lCg8CG+q6NISi3luR/gQ5aSGoJDgPuSljC7qkLRpaYkmWFANXiX+DMRRQu
         tn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722361; x=1741327161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PriYakVb+c1J8nOvCrogaGJFCt/pnunKJ29UwQZ0vI4=;
        b=euvV+WHX1mCNc+iekhywHnr4BYVhrSOIFKrGYGClGmd0j7HatVQwwY60eOqObpZM76
         ODPKJ1NH/vycAJ0rDpkI9ATmoLvTO16YzHCJjJ7VfIf6OMOMCdpTmT7xEo5AQFg6x4s5
         QesJpkL9e9hpfKRbpN7DuuBcuJYK4krTTyd0yKzJObiP8emsNcwVvst4O0sR0COXbDVN
         HgUW0XaQn9jf/TjooX0+xnQIAc4WzRI+hzA6YDXuWxFrzQgUzBp8OxTMOc+1JeA4ep8d
         8ygPACSxTjg1wyf0/6Nn1UCVu9Wl7mMNI8bpHKFHQjI8KDhiB+yDjyQG3lwfzK+xfuGJ
         ctXA==
X-Forwarded-Encrypted: i=1; AJvYcCWCIJJoyySfqeggN9x5HrXnfW2To1TdrR7djdWuAjqRJm1jVUGefDqRp1vvoyyVnT0BRZrpmYpHng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84XgxNFlIsT5IMcSJraw7md3Af8WlzqyF2m0ev0ZVO4isYrb9
	XH06k4sB0eznirpr1FGVGAJMZrMPqKbXMyni2jxuz9BhokcCVH96Okot0woiHQI=
X-Gm-Gg: ASbGncu2ujOHLltTPrWMIffVqJbTw0kVA1lN2qfkjzPGfmC+o5davfTkipxSlm6mbvA
	W6tsKzysLotcxkVx+6aTW3ANeDiE9rd8ELs70dIaNXEvdMo/ahuJKdcSsd/cAVjn7F1qQab9732
	kIr8WziwMhbbdmxFJnzz42PgjULvj7MwmnAr/0QBPbTqDIzFb4Ekn5T3i68xZGWr6EDFMIzKc3O
	eB8bNJOdk1DzgycoEpCYeaaDyez+oBiLTnbrL34CXzAz2ozszXyO4mLRIl/60ZJQgWy6BmFYmmr
	3bH8bHWB63rcgyh6SGv+Va9x8ldru2ZlYrSHSV0cqIwM6IWt3pfK6GU+gj7t4c4n/M18aqJkIuQ
	aD9D+BA==
X-Google-Smtp-Source: AGHT+IG9PoCaCD9US/sZ8xzPdrqNXv1OAhd20a6O6eJB66JwvP1sBoQa9RCne5WE85it4rhFDzdVDg==
X-Received: by 2002:a05:651c:400f:b0:30b:906f:47e8 with SMTP id 38308e7fff4ca-30b9331a6e6mr4657411fa.34.1740722360736;
        Thu, 27 Feb 2025 21:59:20 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b867ca299sm3909921fa.61.2025.02.27.21.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:59:19 -0800 (PST)
Date: Fri, 28 Feb 2025 07:59:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org, 
	thara.gopinath@gmail.com, robh@kernel.org, krzk+dt@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v9 4/6] thermal: qcom: tsens: add support for tsens v1
 without RPM
Message-ID: <f7kgyr4oaftjofo67kl5ihn4yzjf5nrzi6n6cc742sae23ujqd@q5klfmyd22lx>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
 <DS7PR19MB8883C5D7974C7735E23923769DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR19MB8883C5D7974C7735E23923769DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Feb 28, 2025 at 09:11:37AM +0400, George Moussalem wrote:
> Adding generic support for SoCs with tsens v1.0 IP with no RPM.
> Due to lack of RPM, tsens has to be reset and enabled in the driver
> init. SoCs can have support for more sensors than those which will
> actually be enabled. As such, init will only enable those explicitly
> added to the hw_ids array.
> 
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 48 +++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    | 14 +++++++---
>  drivers/thermal/qcom/tsens.h    |  1 +
>  3 files changed, 59 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

