Return-Path: <linux-pm+bounces-20160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA152A0803E
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 19:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC861680C0
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CD019995B;
	Thu,  9 Jan 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHhAq58a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19719DFA4
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448848; cv=none; b=KNlHU6ba041EDHu6A4Zx38EBD/TuCXhJmwLS6wsyQY5NrTSIGcw1kjDG3gJv1AATJ2Raj4icbTgOLew/wmDItauvIX9nkc8IPGz/WnvzdosS8XUvscJcA4tnvlqDdPhdlHDOkkknAfRnyS3E8ZpfnXidS0shLCHPN0ILorzlx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448848; c=relaxed/simple;
	bh=6rD5kJ6oNKZqfp61+BrJaBStpKZz+WxfOE5XGLVTdiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmUbtB5KNIiDSKWTpRmBNf6fu9xo3Zqjl4rEG5Wl72cOwET71CIMwtD7lBytJLMpIW3KqtJ+cMj4NU+hGQEfSVUhBQXqxxXdlSFpraz2ANCVVKYkG9Tf2q7q0IlUFrLizAc0M1DfErP6y+gbHjybpAZbkhtARgV6hD1vNTiJo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JHhAq58a; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so1277122e87.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736448845; x=1737053645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rD5kJ6oNKZqfp61+BrJaBStpKZz+WxfOE5XGLVTdiw=;
        b=JHhAq58ac5uWUAXYacSldDpG49e2dYFEPzWMiwa7j5EWuu62XtMQ7kEkgXOE+z256g
         a7Z3YVgJyKF+N3WRQZWMVRslbQ6uoGTCwUAhEehXVXX1CRnsgju21PgBi3KOCiyXe6sl
         9cG7Whrbf5DUassmk5JALXkbYlnF8S6zeWskzFzgIgRcwZzl4K/4orTKB96L5TUw5psf
         ltm7RdDFiScrODbc916He2szMv2sRg59YBNVYEe4Wz8YfuUpcoL0qs1rac9A6DeDR9ex
         pNNdLGm0sMAYdpXJwJcUGrTnHekRHL8Z33P0MQ69oSyz44v/GjXkG+sVqT8Ktpaazti/
         fPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448845; x=1737053645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rD5kJ6oNKZqfp61+BrJaBStpKZz+WxfOE5XGLVTdiw=;
        b=XOHdl6GPJyfE+greaFuvaJrdsRfA1jpwfNiMkW+vak1ZMDsEL2cIkeN9RTBBM+GC4u
         mQyV7E4KVt2YWW3KPFmHlyX53N4mSvW146G92LPLoviFlw64195wI9QB/ta/v1yP2vYa
         I12ekHrTiBmu1zOcId8JjK5+bYD+REyhcGCsi4Bp21s/hbzQfc4ofEmF4y8WJ9S2rPH6
         Txdm1o6OX5M4y2fX7FvtsZv7f5PW1egX8K2LbHwgQ7UmIupQ3ZKsnQ54+c1/8QWKWYdG
         5zvMN/co9PqrYvmoezED6tZxGTIucKb8DBLX8vuSNgtA7iSLSaWLr4rkVXc3c1EeuH04
         +dSg==
X-Forwarded-Encrypted: i=1; AJvYcCWnhM95slx0p4186XrHnipa0JRz5Xloa73a6jYAVLBhn32Cn+QOE4AJGzS4TLV0xgB/4PClBf1FfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1BYAyCCyLOYiV50M6F1hPR9Uv2SXuVJoeOxrTuW3R4iFvgWe
	N3K4zZCVPV6j/9TdDYYwG5V592vXRLxsD1/cRrTfCdpBF9dgRIdZitunFk61k/BMhPqDyUNuq2P
	XHUTAJ9aabpHJh7CjuUahZRVkChQG+OkolhuXWA==
X-Gm-Gg: ASbGncvQcEvoe4p7fneS1EcYXjZgHt9aw9F3lH9TY7YD8uiLYT4uz1khSYsUXEIUAs1
	TC7BNbBMEBFPwglQ4RWXpkZBe6S9WvEpjvj03
X-Google-Smtp-Source: AGHT+IFUKN3gCG+reUubOj1ToiPOoBLA0OkmJSvGwhuKi7K8xqy12CnnwimI96TU3tjzN92TC8wBnTQv0QFNMwvUx8A=
X-Received: by 2002:a05:6512:1053:b0:540:358d:d9b7 with SMTP id
 2adb3069b0e04-54284810eb2mr2197592e87.52.1736448844953; Thu, 09 Jan 2025
 10:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107113346.170612-1-hdegoede@redhat.com> <20250107113346.170612-6-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-6-hdegoede@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Jan 2025 19:53:54 +0100
X-Gm-Features: AbW1kvZEZOMH81MIXR0A1BfM7tPY1FakDVA-YcXlDJpCzeZlDhK5jLGeGBKEJlQ
Message-ID: <CACRpkdYfeHKdop7eMod_qaOiZLzM15mPcdfJtWghBA7zvyd_GA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] power: supply: adc-battery-helper: Add support for
 optional charge_finished GPIO
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:34=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:

> Charger ICs often have a status pin which indicates when the charger has
> finished charging the battery. Sometimes the status of this pin can be
> read over a GPIO.
>
> Add support for optionally reading a charge-finished GPIO and when
> available use this to determine when to return POWER_SUPPLY_STATUS_FULL.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

