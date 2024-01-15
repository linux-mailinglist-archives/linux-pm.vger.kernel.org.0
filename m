Return-Path: <linux-pm+bounces-2187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB082D4DD
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 09:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC0B2819DB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jan 2024 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05D1842;
	Mon, 15 Jan 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvnP0Qvk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E4441B
	for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5eefd0da5c0so85640007b3.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jan 2024 00:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705306012; x=1705910812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywYykjDVyDnhqbLmXPItjXd9rDMfaLAcvVbMcZlWrMc=;
        b=qvnP0QvkzWtxmFT4sJm+qrZ1oTqFFwj3e7eNb3a0BDycCCpMd3sthK5EywcEIvvY1d
         AI9F7q3WaAKYXclJcHXZUAVWeIKYZABJA3edn/AoQDFhWYfcrhw2EswchiJKmNGHs2TO
         aQ9S9iQ48a6tBRcWfN6SrstQg4d0UsA/TOZY8gUK4yAea0WoNg0DqxXDzvjJMSQI9KQH
         nbecYPt549M7zvNZql4m+VOUJcN8B0c4j0YMDEx8lqKCs5Vs6hROUX3/Io4pdJpNMOdO
         ym4H+MR5I5E+U4FxalmT1i9IQkf3iyynZSa2VBRw0JNLR3K+M7/EOWSMrwsH0ktlOd7t
         GuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306012; x=1705910812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywYykjDVyDnhqbLmXPItjXd9rDMfaLAcvVbMcZlWrMc=;
        b=j9brkyZR9eREc5QoKGzsUZusgJwzUpL8wpwXtffU1QVlzyKYb5/3uLlXq5Ex+G0zv5
         QlDKfDjzEfJbRz4NZU+a0lLTCJBnCgNEBn254RDzQFVd1CAnoQGGDeirdfzkiTlElC8F
         APC2eiwe177tQH5tzbsVu8AfgGXA5rhjsO3td+l38zuWr4AtSqNoDWpBEbjrUN8B+9en
         70u9KFCH1jwb1MN+QDgyL3cuAuBhSYHzJo5K9A0TDaK55mNN/inkzb5TmeYzxt/u3JEG
         sIUUbJUIFQU+JIpBE+9bqqMJOr686BcZffHtC3+52UowOzucPqC7CJMBPUY+TEsqv7vn
         pVoQ==
X-Gm-Message-State: AOJu0YyAn+zH/LNvNjkfbM9KjZ1SQRqgm/sWRMASSLz4M/GhYlJPi+UR
	EVdkh2Y0dyQCkygoOPcIVgg5SpfAOvpkCrgrZ1/4IKdEiEOO1A==
X-Google-Smtp-Source: AGHT+IEgxY63K6dbPNqe5t5aKdNJqQSwAdV8H18tEikus5hYJB5ntbSFPEOJ/eSEo3wY99CHUxcx0Iz77QWl+1X7qYI=
X-Received: by 2002:a81:b3c8:0:b0:5f7:590b:cffd with SMTP id
 r191-20020a81b3c8000000b005f7590bcffdmr3657129ywh.72.1705306012083; Mon, 15
 Jan 2024 00:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115010117.8383-1-rdunlap@infradead.org>
In-Reply-To: <20240115010117.8383-1-rdunlap@infradead.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 Jan 2024 09:06:40 +0100
Message-ID: <CACRpkdZ16H==9RAtyy6ZxTvtjpm8e4pMtiN1TRNVrW8qNcyFwQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: db8500: remove kernel-doc notation from data
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Hongbo Zhang <hongbo.zhang@stericsson.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 2:01=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:

> Don't mark data with a "/**" comment. kernel-doc does not support
> documenting data definitions. This change prevents a kernel-doc
> warning.
>
> db8500_thermal.c:27: warning: cannot understand function prototype: 'cons=
t unsigned long db8500_thermal_points[] =3D '
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Hongbo Zhang <hongbo.zhang@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-pm@vger.kernel.org

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

