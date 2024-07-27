Return-Path: <linux-pm+bounces-11469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0659393DF11
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 13:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E95DB242E4
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668674D8BA;
	Sat, 27 Jul 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iqxpCX1d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD459143C55
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078160; cv=none; b=R51OTQqUrIpFcGGF0PdLuRIVdwN3a5SYliWLvI1fz/VpWqyLhdZpKZTbWB/rD464JM2koUP2tt27jBBXyX142yj8wAyEALS0pCs49t9pCHR/1Sc6fOItSEfw14qwjbn51QgH4w4aEEIPoYeRwbViRdOedadkfEU8Rc3G26ZTdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078160; c=relaxed/simple;
	bh=V+YDUSc3nGYr1WxRfHK9/D7VF2Nro5Dl90xbTvXtMhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THYmX6P8ceOM7STymnLKks4FfA9tXROfPN/4WhpuztZjsoppZZ/ePWLigZImUtoVtXIhLgbgaAdYzFOBi4OAoT9dFplWxTbKxYMCYzwFqlCA5O8WsHr65SXvZHeAnV5PRlXoGv2r7f4BXr7VY/YxrW82qKhh6GYsPJd0CJWmnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iqxpCX1d; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso22785181fa.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722078157; x=1722682957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jye8ZO2/pki4i7qm4KDwuAM4qsHOMHYsZkmnjiOoEkk=;
        b=iqxpCX1dkxM06GEE/8m4VPEIYtPVSswuO+bxJzFEisOa8Y4zk81NosIQs2tJHsTcat
         K07C2H2UqVQjfHaaKts1/O6X/RmKZAhTvJr2xmei3oHnh4lXD7KAVHgXmKsfXiLfNqal
         R9wQWxQZv7PSOabudgky36PGRcaUnyyOaKOZ3cmca3OpYquCwviBHzCPBlGwJiXNyH88
         hQgxy2p32kUqLoBYe7FBitroj2tAX9Jl8Vm91lIjHbcdJoJA/f0lZ+DixZVgupSe6AWF
         JKbEYQGFL8EWuJFpFIekbD2ZRQLY4T3VJNcleIWQjUUrKQbSXkVFzTixReU1uo8PuGyH
         rWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722078157; x=1722682957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jye8ZO2/pki4i7qm4KDwuAM4qsHOMHYsZkmnjiOoEkk=;
        b=R4pUIONVdKtGs+CRw/HZH7jVs92xBXgx6/gDlrl55TZ9aCQUPumQsf79WcbvTBfDUm
         9xUhYkmhhZDzP3c6Qto66V290xs7arhT2s4z8/iEciqqAXrjNXN3h9FoBNrqajLgW1e2
         3pxmaOWTiwn/Tx3e3cEDCHXamnXti6Dwqn6D3SRLPOYYaXllZckozkjy5Cs6Yc93K99y
         2L4Vi8pQ3BAvIQqFU4hEdV2kj6rr3/UQoIsVWpc1hq1v7oEyyN0b2OGWQqwkxulqBfIl
         pPcH8n2S6EZUT2uQqCuUI51XWDbu/pWxN50qQX09EJR7s4YLdXCtQuvFNuBnHlg2bpcV
         FRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmcPr16QeM0+ZsJ0V/jZtOhFSFTQRiul0MuQOKaryqTOqQuDTebzOROe4BvaJabs0Ucbk+ORqZXYpaCnzl6sZ59s4gcq4wE7I=
X-Gm-Message-State: AOJu0Yw33+vXYmj6v1+gPO2CdSK+/SK3iQyOq8OrYrGqpdBtxWQZ01jx
	QobVxHgp/2Q+wO0UuFi1JMpWKJaahq+ZVZWL0zzxlloTThM5/9G8AKfIZg2MY3c=
X-Google-Smtp-Source: AGHT+IE9K63HbHii+F8cpEh7ccZeL65+H13yCLffjMNQtukHmqqedaSKiBaVF/n7Xsgj2haKQ1NhgQ==
X-Received: by 2002:a2e:95d0:0:b0:2ef:2dac:9076 with SMTP id 38308e7fff4ca-2f12ecd2742mr13863451fa.11.1722078156689;
        Sat, 27 Jul 2024 04:02:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf53bc1sm6887531fa.58.2024.07.27.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 04:02:36 -0700 (PDT)
Date: Sat, 27 Jul 2024 14:02:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Add status to UCSI power supply
 driver
Message-ID: <5bnu2usyw54rlqvo7msq4ve6rmsk27jeouegpwymg7m3zbnx7m@x6u3gi3yscv5>
References: <20240724201116.2094059-1-jthies@google.com>
 <20240724201116.2094059-2-jthies@google.com>
 <tzljywuym6jsh5q5iuc7rrtq564d3ffl3e4ltuii7xzkd6cf7d@2nmj5qkusbkt>
 <up2clptjacrc2n2ibzkpv5od47pky6im3pzzgjuymm4xd7ielu@ulg7lb2u5lih>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <up2clptjacrc2n2ibzkpv5od47pky6im3pzzgjuymm4xd7ielu@ulg7lb2u5lih>

On Fri, Jul 26, 2024 at 11:30:37PM GMT, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jul 25, 2024 at 06:31:00AM GMT, Dmitry Baryshkov wrote:
> > On Wed, Jul 24, 2024 at 08:11:13PM GMT, Jameson Thies wrote:
> > > Add status to UCSI power supply driver properties based on the port's
> > > connection and power direction states.
> > > 
> > > Signed-off-by: Jameson Thies <jthies@google.com>
> > 
> > Please CC Power Supply maintainers for this patchset (added to cc).
> 
> Thanks. I guess I should add something like this to MAINTAINERS
> considering the power-supply bits are in its own file for UCSI:
> 
> UCSI POWER-SUPPLY API
> R:	Sebastian Reichel <sre@kernel.org>
> L:	linux-pm@vger.kernel.org
> F:	drivers/usb/typec/ucsi/psy.c

Or maybe extract a separate USB PD PSY driver, which can get used by
other Type-C port managers (I didn't evalue if it makes sense, i.e. if
the TCPM drivers can provide data, I just assume they can).

-- 
With best wishes
Dmitry

