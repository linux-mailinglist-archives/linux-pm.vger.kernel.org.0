Return-Path: <linux-pm+bounces-3559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C0684CF3A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0158A28263F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Feb 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD103823B7;
	Wed,  7 Feb 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9jcQgDf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DB823B5;
	Wed,  7 Feb 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324423; cv=none; b=Sx8/xRXb70lP8kCyM0YtZjgpXKtgQcA+RUAVMZyg/ypOwpEyHIvpJsfVaSUwSuHqICuV4nLykSyuxzZ0zNe5I3DatI3fWvTSPa0zYECNZvYwGvx7O0AsWY/JW7+aOFs+DtrnEHZALAjNTH9sY+pVRxb60uqZyG+CjhSSlvfH+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324423; c=relaxed/simple;
	bh=ow/h8HMMgjieSvpBo0RQLfojsUZLKxwQxt9Zr8Urlus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgllB7QUSyatiFaG7eUI6mNNyiPP1qq0Hur0kGIpaGUNl2HQVG9pedsTs4V/G5FvRdXH5prjv0Hd5U0yJsJonZLdnbXeictBhPJ2nc13DW8gYvP1S/MaLpXUpNZPT6Eh0Et43DPoH9lyooweoJU5U6+lVpSDxR0DlVH2a86gX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9jcQgDf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3392b045e0aso556159f8f.2;
        Wed, 07 Feb 2024 08:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324420; x=1707929220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNyBJm271uKZuxLauB8cEdJcYLbaucijNIBqjeZVchI=;
        b=h9jcQgDfoqKpS83QQgTu4HymBYIl3ImeTjXjWPPpi2VmaEK7NJjXurn5JBitTLBc+y
         1vX1JMpCKL2KlPeVmnqyJbCLtQEvcbHsqKDlgN1w4M6dhRGcgsjl1q2YWCt//9MzxMtH
         1ITFNFCedbr5cxMn5lLm11FiA+J5QE+Rcl92Gi4rPOv8N8JTacQrSbmq20J62f0p9u+v
         11ExE5owH/ixdkRHvS/lIdrVU95A6nCVBPjIpXIELnLmsrePauWs4ZRLoeigtt4icM41
         vj+8YVDRtxf81ywBh47Snc0G0b/p/icJPbEOTfrwdGdsF5Y4AXfZKof9xOYRNrNNkUhu
         yMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324420; x=1707929220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNyBJm271uKZuxLauB8cEdJcYLbaucijNIBqjeZVchI=;
        b=fPNEOCs11Syfta2XGpDIMHR4JxZesTpOuvRKFkhAlNlKO4E4jZuGm9MEfxVdemSfBC
         Z6Dm7ng9YBBwnS9JxzU4DO6K7m/Rg4YNN3slfV1sl5scROueiWWOa/gGPS/o/wVBJQuZ
         EHAYlnZ2zPRvfHTkIYKgEy5kFbb4uiKuK8E/qweg2QNt2d8+O+qqUtn4+aPbVYCca/OW
         FW8gMQBovaEWDihHQHlZZo2h5IvHHzcwelcM2OXMowjkxdbEqm2KqPcXJ6oI4ZZpR4HD
         yIUJOltg6iozHhvsMQYbWYjE+QVjmY8jVapfyrs1hCbU5YUyqfaJK3/DQPoLokIlKq/I
         3l7A==
X-Forwarded-Encrypted: i=1; AJvYcCW2hMHMxuobt3FNHtR/Idqx9bvPkUiVD4BI0rQNy7SPzsu8D6/cRXGsaY2yPrQE3raO1HP/AhWqBWTqfDPRfiVy1EwKFwPG4R37muCFqfsl7M/k7WKVNLNUy77tPY81uYhgbRkr
X-Gm-Message-State: AOJu0YwCvzXSR0qGdutRikXrI2j643P4u0LdIpimZ6vddnF9ChNFtIhq
	msQvDrNGrJmvJ/uNQiUVpBRDAFNiToDEjZDFkbDiSH5uXpMQ+Xfl
X-Google-Smtp-Source: AGHT+IHLJL92TguC8sEtCjhxW9AMlDys16cKTdv7JQMHIf6bMiiMlyMp/b/AkkcDwTYaRG486wm0aA==
X-Received: by 2002:adf:e707:0:b0:33b:153a:de12 with SMTP id c7-20020adfe707000000b0033b153ade12mr4296483wrm.13.1707324420094;
        Wed, 07 Feb 2024 08:47:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqIu/ontdqSsx+JVBhpOZoQVPeF7HGMkI1l8OZSOezAuCFfeafZ7VwFqKktb++AMgXcsfauN2GbRULJukw/yaAvAlnhgcvVWXVVW6V4rH92t7MlbwG4Yo/SQhJrk2MuVi8Ub8xt5j+XLoeH7NDOdwXMLOg0inuHedvGnYDnmrduFkJjImVzqWbUJjxZYPqApR/Fqkn0pZgGLD2BMo2kFpmgDWT7bc2jJrxDRd+8ToItzRZWloeUkYZMh8Hw8EspilGIhSZsB+rb4fdCw4TZ0Q3SFOO7waQ+c977bTHfVPWH743h4Sj+LivfDm+iIu7QwzWsmoXwWFkb/Zr49OX2/lejz64/1OfX16LTiQFVDWyWcVZjJuBQiiYMlZGhgtZnUMXEEGnHsyYlfdq9JvNaud0K3qSfB0s1NT+rnBswtQkUzOUMdQxFTMxHTruoEifT0abtMOoJAsuUBwNLjCg9HEd+FJgkzevHXtCFsofNd8zaQHP8yfVf2VeRED7YLZIMnUXHFaOgdkyZW+1GX7pJ+D6PbcxGGTG94UxlKXE4c26qBVHzRQ=
Received: from eichest-laptop ([178.197.195.228])
        by smtp.gmail.com with ESMTPSA id n15-20020adff08f000000b0033b1c321070sm1871607wro.31.2024.02.07.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:46:59 -0800 (PST)
Date: Wed, 7 Feb 2024 17:46:56 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Amit Kucheria <amitk@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, Josua Mayer <josua@solid-run.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, manuel.aebischer@netmodule.com
Subject: Re: [PATCH 3/3] arm64: dts: armada-ap807: update thermal compatible
Message-ID: <ZcO0AAzK+P8sYHdX@eichest-laptop>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
 <E1qA7yZ-00Ea50-OC@rmk-PC.armlinux.org.uk>
 <ZcOsjRzE8V73wNtT@eichest-laptop>
 <13ab003d-7449-4d6f-861a-fa2d0c3f4ad2@lunn.ch>
 <ZcOwB5xShhRoX5yh@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOwB5xShhRoX5yh@shell.armlinux.org.uk>

On Wed, Feb 07, 2024 at 04:29:59PM +0000, Russell King (Oracle) wrote:
> On Wed, Feb 07, 2024 at 05:25:59PM +0100, Andrew Lunn wrote:
> > > While working on some thermal optimizations, our hardware team
> > > discovered that this patch is still missing upstream. Is something
> > > missing or did it get lost?
> > 
> > Patch 1/3 had a change request. Was it ever reposted with the
> > requested change?

I forgot to mention that the other patches were applied, so it is only
the one missing without change request.

> 
> I don't think so, it's just another patch series of many that I have
> that's basically low priority, and other stuff probably overrode it
> and I then forgot about it.

No problem at all, thanks a lot for the feedback.

Regards,
Stefan

