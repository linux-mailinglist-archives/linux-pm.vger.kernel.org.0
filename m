Return-Path: <linux-pm+bounces-25908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624EDA96E1A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38FE7A8AD2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63835199FC1;
	Tue, 22 Apr 2025 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1Y+XNDe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EC2853E7
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331308; cv=none; b=BmA2iD+UM+muUNJpfBIq15fyx9tvB30UDFjQ+12rK6iR2sLOTRARCJCcMzs/N/R/w4cnw4vGJYv89kElMex69+K+6xAbhlEwcRfmNHolLZQlQNcWChPBQoa3lz882lMT7aIVZoY17wSnC/jTVQq52V9GhN8j7zdDusudJVlHHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331308; c=relaxed/simple;
	bh=ht/b8hOowhBPrZFB3PRaz3GwnJG9WOhGtjQrBFTFXYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2bJvLf70YEyAchDxhw/P1VYPrRl7iJN/bg86X02Q1qew0hA98SmqH14ttEqfGpJJoo1djK/4/ZjOO8kO/ok/NWxFQFI9QOZZZmrkovUWNdyK9vjnOt1q4c576wDjf728SzpnfhqUtNOuz4v/BSTyFkiqobyl4xuVLcNNE4xjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m1Y+XNDe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso866838666b.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745331305; x=1745936105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAPsYi7X25L/caX0EHEb02SNjtKsf53q45QaVhQBarc=;
        b=m1Y+XNDe8DEWAKdnmGGi5vdj/XWB24Q9VWs3dHEEMRFgWk673wuNmOpidl2zs+5753
         fYJAFFCocV0N2zoYS6NuaEw4gme1s2oFvtlKaMoeJ/2IM2O7Sp8dn0X1lrjdep2VgOiT
         1xG1bhk1ZPV5eGIBo8rL79O/qcjL+tUhnuqGrHiutUK+xpVEUIMlQfRqZKCNAx4XUpSM
         P31qxspVDp0qq7/AMfL/yN/9e/WOcz44li93JnhGmv2K+k8xbxcd0U8uOQWOgxlZlcie
         r57f6lqdhqvyV+mSOaTGfnPtBrT4BlZj9n1fru9sCxIz4ww9F3DuuB0HZ4fgI9TvWPCE
         eBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331305; x=1745936105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAPsYi7X25L/caX0EHEb02SNjtKsf53q45QaVhQBarc=;
        b=Df4sTAZRPDt67mTg71dSOQ3BLBGM2/Dp3Vtbwq0+GPiLrqGBzs6xpfuULikCaufCZ5
         r9rFqqfkLK5q6PiAc3gqI9CqpLJqAVuVyti9upWHxi68yl4tDn4XTh0ZWJ7TajNVKztb
         ct7zdEhkLKzAxJkIWBoN+hJXxxE57MFVXdORm/hTW/i6nX8uZfC6pTv4oqBAUpKj2UC4
         UoRAi0nrqUnBBmNYIcp/fmzPhzvaHP59WViOUHR7SOStgvYceKT58isiJg3FHsowurd+
         MjZ9jEVkBd5p+xWzdgIwKbNr1JlgJgpKS8EBMX472lqTBACtUspSvbpWFLjoPzeNfTcI
         1m+w==
X-Forwarded-Encrypted: i=1; AJvYcCUvwYr4YZdvEuB/sCE69xpyTfqBXr5qFHBnYHdQjCrshFde+11VX4lebTqURlWzs1BP/FUd8vU+Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRmlEOYOID7keScysowPHIlNjuRv0M+XDX4A/zNJDi/rQgJn3
	lVhsS6v1eVkVHrqZp6sthgmKXGtVw4KpI9L3lJiu3HWn3ObYfpYnUdnj/Wn/pNI=
X-Gm-Gg: ASbGncvegAQCyUeRyvZ3ITHmOp7upQjngSj6/3CZRVLSlK5j2Lc43BohpanM+Cj6Vmz
	cJIOGr3WUroDdWRRRVWD8QvmBmjD8dUneWQrJNeSeQ4YAaubsrzXdwPg8yHuGACETSMpC9atrAq
	WzbmJ+2uVjpSq/S1e15KxtHkbR4OFKB7pRSvnIwT+4VI7mxJT+oLynwfD8RUnXhI6WFVGLzz+K7
	kg3NzoeTMw6AUzo3Fc6ppo+28G99wZdpLKGNx0ZrnhYCAMO3sT8dj7k+8+hDPLHX27ve6Rmq2rv
	4c3EuprHZmoYJ75NBEk2XAO8xAMD/BNbyGHIPw==
X-Google-Smtp-Source: AGHT+IFeSK5uLgbn1NZKQrylDdRtKmBHDZDXywYGuDfa4NwCwFDz1VJZvajnIXoXSg2frAfCpTf5uw==
X-Received: by 2002:a17:907:3d8f:b0:acb:66ea:5786 with SMTP id a640c23a62f3a-acb74b88937mr1434632166b.31.1745331304772;
        Tue, 22 Apr 2025 07:15:04 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef468dfsm658630766b.133.2025.04.22.07.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:15:04 -0700 (PDT)
Date: Tue, 22 Apr 2025 17:15:02 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] driver core: Add dev_set_drv_sync_state()
Message-ID: <aAekZizB9lR8E4Rw@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-10-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-10-ulf.hansson@linaro.org>

On 25-04-17 16:25:07, Ulf Hansson wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> This can be used by frameworks to set the sync_state() helper functions
> for drivers that don't already have them set.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

