Return-Path: <linux-pm+bounces-17509-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E2B9C77FB
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF4228AE74
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C0F1632FA;
	Wed, 13 Nov 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehznu/bs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1C1632C0;
	Wed, 13 Nov 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513414; cv=none; b=ZjCwCXYn4HeXi/lPIRFGOwvHGBUylJB8QzKp7c62WbZgTDBRfPGBdbLBiy01qICfXuvSi6GGssrxcOt56/9Mt4tUPX5afPUIlNXuYuWnOrIrru9NfUjbLSyBwnPiZbvNj3ffjgjoSJD6y0etwlFcf4DAz7o4fONqLAwewxgpTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513414; c=relaxed/simple;
	bh=AWVBAE6GkeOxo3grGiyNzxsNeZyTdxtpxenoz96dMuw=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su7BDZYvQMe597GfDq0cLmroeNvNbKy4I3ysBB3yiP2tsH6qdU1dapH/cXEYORvEvTTLu/ULo68fYMOYRMuFCGUqVjsM/ua37MsOqjIE2dxJzGpXeWHMKv3xB8sO4uvSEpqCcbMxruWdS6GLse6iHFyZ5qIDij4btELyjaT2i2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehznu/bs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43155afca99so5709965e9.1;
        Wed, 13 Nov 2024 07:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731513411; x=1732118211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bJIphfUdq+yWEh+Qc0geVkF6Ht47rK0Zz4xAXQ8/Ir8=;
        b=Ehznu/bsHT0atPulpku4WC8cYP1mtgbFPZuI8BssKhZ/Osm9VuIBtOFF4EaOxpsoPg
         JpPbUQw/F8sDlXW6vSMhPFfuGSMA5l42OjwtnhZo4+xbEE4PWwFWEtJoiZtUbK1SLyxo
         NuxFlNZdAHsQKzwSbHHequeQb4gyrBwFB7AJ8GJzm5mNup+3IoDuQ1UdV+ctkXnZmt2j
         7ZPjR/0zDMUVA8m3DqDzjOENONQIUIMCwMcdSD1pUBeg0xCIUClGWfWzc8bYPYgWy5lK
         gCsJpu57UxZnD1YauJgpzEMrSCuAAG+KkSd7jOAyzyH+cGMekxteyfw6O429fLLSkxhD
         PKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513411; x=1732118211;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJIphfUdq+yWEh+Qc0geVkF6Ht47rK0Zz4xAXQ8/Ir8=;
        b=CPR+ztYmMyM8nNB34hZi9jzjYiIzMAognIrWmjwm7cHOc+PsO2MeQRFwyLrsm7EVxG
         YOO4SeBwhAGpKAh+wWFyOSfp9zqra5TOmHd/Kv2hfOSZEbCgMdxqJkgWA6xS2rspjcu+
         9hvflLnrEC9nhvhDm4ak8MdPw5frlhonke1von5zkZSXW54LN/7fmLtb5Dh/k+H5MlVt
         2nB7uFgmcQQfCRei+70VYkI65SbO4g4uCQ+xMeyrTjLWT7KlzP1j4G7+UFhvQvhIIczd
         TnbJnCafGrNu7lYzpjhx2lLnOB4GZ/qoXmKbiwwVBwpTyUDNN9BGEiSIjTqAMhbjykfg
         n7hA==
X-Forwarded-Encrypted: i=1; AJvYcCUfNRMZFAhkx9DmmgmsytevS1x4sN8xafADM3tqBFWsqJF2qnuZ07w0DQQ+i0OyxIms+sEL69NgF4p9@vger.kernel.org, AJvYcCW3VlfMDpnZeQB0iJyWuKbGOWc89hCffp2lYDqinUscmWxXZSqEev9Bbq3PCa7oegVPmiPWE1mCTjQ=@vger.kernel.org, AJvYcCWts+Mh9mvnlrBXJAt3PR2iVbdK1X14cspn5EyQt4/9bCvbYrhjbRTTGKM7MYcxBuSeSZHJ3H/VgttpHD/R@vger.kernel.org
X-Gm-Message-State: AOJu0YxtO/C1Gzpu2drWuN0pOpiIypBK90EQw4WKUaEZ4TnJJZ7+PFKe
	oB3tKTFa7QiXTATjvVfsmrV1xoPGyGGsJyIT7Jr1qR/vwGDPhAwJR74I7g==
X-Google-Smtp-Source: AGHT+IEQudECMomeQpuJIJZMwRxIPD8qUjKG77S8dHua+jbgex+J787o8CJngwMb4N0QE3uTCPQbug==
X-Received: by 2002:a05:600c:3b9c:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-432b743575emr175835315e9.1.1731513410586;
        Wed, 13 Nov 2024 07:56:50 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea5c1sm19055209f8f.81.2024.11.13.07.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:56:50 -0800 (PST)
Message-ID: <6734cc42.df0a0220.4521f.ac78@mx.google.com>
X-Google-Original-Message-ID: <ZzTMPdUmY-UczeEc@Ansuel-XPS.>
Date: Wed, 13 Nov 2024 16:56:45 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: Add support for Airoha
 EN7581 thermal sensor
References: <20241018104839.13296-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018104839.13296-1-ansuelsmth@gmail.com>

On Fri, Oct 18, 2024 at 12:48:04PM +0200, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor and monitor. This is a
> simple sensor for the CPU or SoC Package that provide thermal sensor and
> trip point for hot low and critical condition to fire interrupt and
> react on the abnormal state.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Any news with this series? Everything wrong with the thermal core small
patch?

Ansuel

