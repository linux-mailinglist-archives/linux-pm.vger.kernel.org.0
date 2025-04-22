Return-Path: <linux-pm+bounces-25907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F92A96E01
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 16:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD3744027E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31E1EB1A7;
	Tue, 22 Apr 2025 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qd1Cfzkr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC30280CFC
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331023; cv=none; b=oL7j58jrWkvaf0DYLCVb43vj+TkRqRTCucjEBapzZEvlWQQuaM3GB8mp0gpf5bQu5CjyGn9lGMGgt+r5KsOmvVFxQbcXPdkkuEUDZCzPt1sdN1IAdnaJmBCB97sXIwGAjh9jKQWVP4UzWiiffy7e0gR2JOtKlN3uMNUY5+s+R5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331023; c=relaxed/simple;
	bh=ARspZ2ykOpo5aRuFY/beHaoHmbHtJMxGB/pUuZ2VOOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJqwNSveJplFih6dMs1pSHn5fiOWhMtrAuaR0LQt+jOfxRN2nXcUAroX3KLZyqwRs6sn+sjZjWEXDfrmSq9zbFNI6L1QffUvmw0U+x1TGsd6MRXeeMOWyXD5Jk1cj/6K1eiixzPSl+mY6Ss86onEuhTQ+3KjwzgaL0c4Kyp6ZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qd1Cfzkr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso5375273a12.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745331020; x=1745935820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs/aE9VBUtWkbTYcRJAW9cr2FVba/GqgJ4VTSr8qjZw=;
        b=Qd1Cfzkr+u4N2V+dZFXxgQFHDf4ZU8d/q1KOL00OMJ1vqfz01XeokNqYUfifd0+lJr
         ADP5wP3BGU6SvzbxnVvxsoOKsGyyz9HhFRfzyHGN+mYc9kloVoEQQCoftxMEYve/p8kH
         M25lxBiRnNXR+0MpcGl+UUrDSMThzKNiHfe0rqHObJR/ZKLNnEIqrXkVikV86bpPZmtq
         B9wRFyw2KNqZcjgs++mLy4U7PyDJs8sLS3YnbZBvOTTbAvhu8L4JmsjEYtwz+mbHLtiv
         9liRVZgHZ+8r/vy2aBd7Li4TtM+GonpBoktsy9alVBOrtf4RJGBrfKEAZoSoR7LTrkMj
         Yr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331020; x=1745935820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs/aE9VBUtWkbTYcRJAW9cr2FVba/GqgJ4VTSr8qjZw=;
        b=vgs3Abe3xdJtbIOZ10Pg5XKLHwhaHQks1JY/UvKzYJDVMLIYD6XVg/ld4SgS1NXFaC
         A58fVvaZarwTR3okZbZ3SdnSc2t/jfV7EMG253UV3nho+Pbosz8Z5D2pvw9w0/Jqbr0O
         he6G4SVzBDfAEyz1Q3P4GyHu2U/CAZStocFGwLNhdS5OR2JGQNMnhCVJyhx+LVYPXVYw
         jYhEtRFQ1RxpcT5FgJ5rRPBhwW0Ox9W5N8t+ZAL8LJuPggSktE7FNYKIn8hKzCK1vEQt
         lGius9HULYorHq0bji0qxc+GwC3LuuYdw2wcA5oiRAGCtfqcvQdPeSezSBJii+lu/U/2
         FyyA==
X-Forwarded-Encrypted: i=1; AJvYcCVck/mE7hcSddfJESuBXRcUmK8xQ2ySzRHBfT99dPM0eJo62mG9NfwX92iaAXMMRgl41NzKoZGoXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMM7TDAnGRb9QdEJx4yT9t3ND1Fh9uQEwIrApgM4XXX48R06Kj
	MrffT+hraoqSmTzwbUfnVzdIZg1Kg2qjQPRW6JR1KW3aEJo57PsYdGQ5BSwHQ6k=
X-Gm-Gg: ASbGncsr0KpQCb/Hh/VAga3gpAmevKq05H112c+CxfWoqPIcTkcJJaHxfkY0vy3YQPw
	QrfjoFLkD6YJIjTXJUv2QqDfheKAi6ct6b4hcXeTrEzKqFicS9wf/fMpjrek/R00dcjU/DB/bLw
	rCXdvmdhxVrXvcrbW1NpchzH+Sp0lfMv15Y1Ej+2GqCNVQb1t8Yg62Lmm0kcCMw1zsTzxOoBkly
	vQ8Ox2ManSnkOvD+Lq0P8iGIr2/+tWR9p/dpXh1fHurRuON5tDjyrl1seRWiu7B7CIO0nYWbCMv
	rTjK7OmQ1di9ZYr0/ZvmS6hQdjjKbJe62RR9uA==
X-Google-Smtp-Source: AGHT+IGSxDHn1oc0UD2CkTcdu1FzGaJupZaMzOQ7CTorW8aiy1O1jrh0PHmOMnjcVt95Ys7UnKelxA==
X-Received: by 2002:a05:6402:1d4c:b0:5f4:c7b5:fd16 with SMTP id 4fb4d7f45d1cf-5f6239dd7b5mr15160699a12.6.1745331019689;
        Tue, 22 Apr 2025 07:10:19 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625592cffsm5911761a12.35.2025.04.22.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:10:18 -0700 (PDT)
Date: Tue, 22 Apr 2025 17:10:17 +0300
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
Subject: Re: [PATCH 07/11] pmdomain: core: Export a common ->sync_state()
 helper for genpd providers
Message-ID: <aAejSTtrgufWInZk@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-8-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-8-ulf.hansson@linaro.org>

On 25-04-17 16:25:05, Ulf Hansson wrote:
> In some cases the typical platform driver that act as genpd provider, may
> need its own ->sync_state() callback to manage various things. In this
> regards, the provider most likely wants to allow its corresponding genpds
> to be powered-off.
> 
> For this reason, let's introduce a new genpd helper function,
> of_genpd_sync_state() that helps genpd provider drivers to achieve this.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

