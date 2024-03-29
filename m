Return-Path: <linux-pm+bounces-5724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A1892697
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 23:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9251C20F2B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CF313CF85;
	Fri, 29 Mar 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNMSbUHl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106C13CC4A
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749976; cv=none; b=H4pVzpDgMkGQebtRotcwjfhUf3Lb3dLbsORoPRQQ5qepWVAoAsFqNVYXp+KH7kJQ9H50UFHQxyQByydUrOdCVFm3jrs1lbG3aivcw8FPLoIdSsCR5J7OaCeCT2JtX+0JpSzledBGxGMKCfmypls/yRHxPa1PyAGXiOV7uWbxwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749976; c=relaxed/simple;
	bh=nV9Xa3IM7xgXhYdWwGJomDhP7UDLqK2glvaaFhOjZe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n13N43odoYuCzTmYaBwUmxENa7cY9Uta6tVHA6ohK0OmM4aJP/TA9n4w+3cqZ7W+feh/QgCAHPRA33RNspWKlEOi80ZxZpVTxdmO7DOrMNUov7C4Kzj38jtFLieS93MGKjRa02cjSwXSmtxXnRj4RuFYUl4LfCV2wZT2Wgs/ZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FNMSbUHl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690bd329df2so11541496d6.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711749973; x=1712354773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV9Xa3IM7xgXhYdWwGJomDhP7UDLqK2glvaaFhOjZe8=;
        b=FNMSbUHleaOxOZbfDz+u+JdTia9GOPSlzizapSlBoIwxoNPZMUISRqeSed3IryVc49
         Ygiseu/iCAeP9awl3iD9BF/d4uzNj+NdUsSPmi4P3WfcWpSIkepTUCzY/TGZdGMztfXp
         j0BQevPRTm9lzQDXUTpr0NKeqgBGK80Syje3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749973; x=1712354773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV9Xa3IM7xgXhYdWwGJomDhP7UDLqK2glvaaFhOjZe8=;
        b=LqyChdWESbgVD6AaIK1UbRMeaMR9TLesiov5mzEcmO4d0YAl/BX20/+6PVbY3gV8OD
         RXg0u+APZcSQDDKA2sUho+GN4rQ6kk55rmahKEtettyABqgAQCoA2iGgMfZG3As7paNB
         BEGwVo369bo4zdZfh0LcAGI9JJ+bvCPrLcJsX/J+P7LIab0hxmkS+Ss0T6/Bc+XVzw5v
         aT+I0Br9RQjm7iJ54ybgwsARYe3NCvPkQgF6IxDiI+4tBSGkzJxzB53NkmW3GBPeZI6h
         kxjpYf7kfPPy5yNIpDJfVrM38zgVBF85dFFIL7B+ASzYZc/KwkIo3YWHDLS9fdaw6UKA
         o2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM3B2G3unh6Oe7fEhDWFs6/cMU5Qhtq+QsWLKvKk7MB1Yu5T6ry//P8IVt8VuSxGtOgo/tGrUcvIdcnSc/RCmyCJVSh4qi3kU=
X-Gm-Message-State: AOJu0Yxuq41Po3NZYGYCwOrN3VfFPcoCLxS0hUibMzfjQljQhGtE79YU
	v9iJtZTTgPKsO+Ewwp1nWeQy2UkNTHxjwvRb8ckSYzqM1i/4YDLKLUWqmO2rcVcW9R4c57EZcyC
	iJUVjl1NMuEP3ATWj2SNjqKej6VhmbJ24yKML
X-Google-Smtp-Source: AGHT+IGSnhH3MvM5RwIbbS/34YE/7xYi4pOWO8e61L6VZDx1cFIdeGebuznubPkOzyANMTrrgX6Bab4sJhaJDC2rdVI=
X-Received: by 2002:a0c:e852:0:b0:698:e87c:7d65 with SMTP id
 l18-20020a0ce852000000b00698e87c7d65mr3221235qvo.37.1711749973661; Fri, 29
 Mar 2024 15:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329075630.2069474-1-tzungbi@kernel.org> <20240329075630.2069474-8-tzungbi@kernel.org>
In-Reply-To: <20240329075630.2069474-8-tzungbi@kernel.org>
From: Prashant Malani <pmalani@chromium.org>
Date: Fri, 29 Mar 2024 15:06:02 -0700
Message-ID: <CACeCKaduUSrPG7w6hi=SPLwPjdJ31-9peHtyWwkitAhkQaxQHA@mail.gmail.com>
Subject: Re: [PATCH 07/18] platform/chrome: cros_usbpd_notify: provide ID
 table for avoiding fallback match
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org, 
	alexandre.belloni@bootlin.com, chrome-platform@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:57=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
>
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Acked-by: Prashant Malani <pmalani@chromium.org>

