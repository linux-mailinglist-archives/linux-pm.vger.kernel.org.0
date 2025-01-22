Return-Path: <linux-pm+bounces-20800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D1A1903D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 12:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0CF7A3E25
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149532116EF;
	Wed, 22 Jan 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrSuY77B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FD18AE2;
	Wed, 22 Jan 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543718; cv=none; b=XLO3CKzodMUhBGTGkhARX+ypexEbCtS2dR0wgIv9EiMVyjxau1ZQEjCsrd7igqTTMxXuGeZEd5qkDCynGd7EiXOCuVYdzkDisA8tjFtl1pCO3/IPycLIoDKCN8ZRh05WMq7hkmDN+hADJldG87RZceXeepd6L6Ghi/ShpjOCO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543718; c=relaxed/simple;
	bh=ahegWa745mU+Vmqnh+ev9dNyAQR5ZkIBYktO62Z+AZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkMfbtby0hgu459TIMvkDdltqGtcrio56v4a6zbVZec+BfAq9wiePAtX5CuOh6brBRYMwkFRYXWlTzxyo4G4iuWGLPD868l0qIvd4oR9QzPiTSA+DI3Kfems5VS/cIJYN5eLZ6jXRGi7g74bqPn1eSigir9EVgVPkYVAOpIlf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrSuY77B; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso9411138a91.1;
        Wed, 22 Jan 2025 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737543716; x=1738148516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahegWa745mU+Vmqnh+ev9dNyAQR5ZkIBYktO62Z+AZk=;
        b=YrSuY77BnW3QDwR9zcwmSmMGluhh6OMreBy7HkGefmNATHT5ZKVxqCSVULmvczO5b5
         sRzPvvA6AthtbLmh4atg4actrdM2msb+sPqiWRLq6D5obJszrmF5C4eHaJM2Efi0k+LH
         GuD4BNX29lETDdqgwzhhrSNMEnU13AsWG8it+siCbGE1HI6MqNRmG/pZR+djdi1I0VFu
         5zgU5gAFU2My9nQp55Fi2byDRBXYx6WivQT/nBIp8gVsrQaC3jbhvnPo+lbbL6xzgZvY
         Xy/FcMahvzL8aQgJCJdKOcu93m9O+3WsG08st2/1gydfvZTlxNyMKDq+hwTq1jT0oEtW
         wWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737543716; x=1738148516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahegWa745mU+Vmqnh+ev9dNyAQR5ZkIBYktO62Z+AZk=;
        b=ist9xM3497sDkxSimX24inew40lU1pjYHIWpYePCJa4xoYjhZ4mR0cbJBdYdY0qo6x
         fCHdfRQKT30o7gJBhKr5Lr2Qjz260lyXGnasLFZVsrrKV96nyMLPQFjHgPxPcCnrGCy2
         hlpZbPBlzSOSyp5vgKrGNmBBv/V4IfIwm7I6fWFAvzF9GsaYaHNyzpj5Qlu2SYuezt2m
         HGN3SbLBez9HI8mol/W/dj2134BCI+bPCA4cw/qABsbDMZ20BqDwcCWNEI2msHUxuXh2
         UECJmcZph5i7YQTyH6UCp1+VOJQ7HHX56a8EVGSfhDNtYO8xNtZccKgLKwfbzGYlyxQz
         4IqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABSXFkwXsCcasZQ7eBygM8FXvTha9YSE2do+ckZP2PVHlB/M0aqwyosoOKTdJ61voMtMQ6M4dBiwK@vger.kernel.org, AJvYcCUZkM1b8gxmYdBczYqQcljuO4t6A/WuSzQFRKmsNlVP5I26nnmhh8Gcpxie5ADtvTLVso6WXaeauMom4Ci74e0IotmeBvsM@vger.kernel.org, AJvYcCV3mvi7CeaT0C/tzyZkoPqJaKJ0AFn2fdbTDNK5FsegZLkGqJ4V8qScVINbmjNeBXJNd4IZG1HmHWiT@vger.kernel.org, AJvYcCVOYfcu7PpCQUnfn2WMBxvF2O11hYFV9wFtmlDMJvuQWY7QCha/J/y6ObRnqpD8yGeCt40uLA1XZeY=@vger.kernel.org, AJvYcCVtovPxB/Z/8zyxsL/TFXbJ446LNxppNwKDoktyOGBcqlP7cMeFsZXls/3LQEyYFAC9JUgLG1P14t/TOcbb@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgpwnF75CqtHa8W15BUv2E2s/oDjVjZyOXqB+9hgMIJQRQ/7P
	K6uMOinxHI4wndyihBAvRRvhmRMclxzhSvpkvruYkTOTkyzFw/d+VDwTsmZJ0PQCknZlY8UBfSo
	jD7SqRkeYuIIE0X7cAzLF6h7WwF4=
X-Gm-Gg: ASbGncuH42sTPIZpvHNKhh2r3qn2ev5sRzKP8u1sFugFy9fDcmg8rv0kLhCu0Y59Zoz
	6LadhdNpLj/3Tc40wwEiw7FJtu+KQFqDsQFcH+wOv/KvpI4h2xLrL
X-Google-Smtp-Source: AGHT+IFPgblVHaEjnM6nhcreTldchYyIJTpY55eKVObaVzFagqAwIyDjIvNPwSyVAwhYwCsUN6FF7RqNwMBujjZOwbw=
X-Received: by 2002:a17:90b:51ca:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2f782c4bdc3mr26294095a91.5.1737543715747; Wed, 22 Jan 2025
 03:01:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de> <20250113-hw_protection-reboot-v2-3-161d3fc734f0@pengutronix.de>
In-Reply-To: <20250113-hw_protection-reboot-v2-3-161d3fc734f0@pengutronix.de>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Wed, 22 Jan 2025 13:01:43 +0200
X-Gm-Features: AbW1kvYA1CSvpEvQV0avkVcXZAcP3BsGSp9Mve19t_aSvzY4TVkLSF5gkliB-RI
Message-ID: <CANhJrGM=DHmXxKrfwQ80-6wqZqMLx7Yv=jC0ZV0B9D92FAcd6A@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] docs: thermal: sync hardware protection doc with code
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Fabio Estevam <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, chrome-platform@lists.linux.dev, 
	devicetree@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

ma 13.1.2025 klo 18.26 Ahmad Fatoum (a.fatoum@pengutronix.de) kirjoitti:
>
> Originally, the thermal framework's only hardware protection action was
> to trigger a shutdown. This has been changed a little over a year ago to
> also support rebooting as alternative hardware protection action.
>
> Update the documentation to reflect this.
>
> Fixes: 62e79e38b257 ("thermal/thermal_of: Allow rebooting after critical temp")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

