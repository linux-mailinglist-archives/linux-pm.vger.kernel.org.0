Return-Path: <linux-pm+bounces-22859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0EA43338
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FA0174EDC
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 02:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE11487F8;
	Tue, 25 Feb 2025 02:41:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4344433D1;
	Tue, 25 Feb 2025 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451269; cv=none; b=hTeYC9nIl1EyAKCxurLV+8RGhw8bKGzc0/rF9s3MKCLTZdDCkNrHNTjD9D2adXNYE1PAibvJ23HEwTNKGTP9yPuZGjjrmo9RKJp7J0ciY2WMPO2CJemS7VVZgjDDi496Syefc2uL5mFj2VHigUP+h3pY2ETyyDq3K+0r4+9SRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451269; c=relaxed/simple;
	bh=bUPGmmze+2yYO/R07OBpXdoDaaUY81P4TEL18u2/P7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfGh7ncNdAqAp4dZZf+CPbxQkuoAYj5ByMtlrZJ9heqNZ5iHBqWnkCrpH9JCKL4tKGxJXrR2YqRuqdDEFNo6sjoVtQHX2THM9gS63p9dN7rG0tbW5sLiT+pufxDDvTtSvFprFaVzTWxX6XcLhSO7TYdnZSKRWJqBbYliGVZGx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-545316f80beso4543105e87.1;
        Mon, 24 Feb 2025 18:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740451262; x=1741056062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDRQSfyrqWB3i9K9f0iWL42UBxbxZ8n8vvLDHbOhuRA=;
        b=aBXJKGzZFmdCJwyfgBQFFke/nEi9QOQmVWpFmQPl797FqhkXSqKwY0nLt4/oSAVxQv
         P/Wh6JfPm7+k8yErXJvJaJKD+Cii0OxK3WdU1w/FIxBsDTMAsrZa6D5XoTKMNkkFaOt/
         5fk7Fpa6U3n/RMYTVaifocc6mDavW+z4kUEe5lPcUFujoYAEkpzrNEX94Etk3d74dRVd
         ZT0R342aYzP/NuhOK+HH9Rq9vNwpTa3FjmeYIgH0m9snse+YNY5qpWr6JM7woCSAauKE
         5ST0VXgZw5TFsaUgB5ZlgWsY5X4oqRJPBSE3pbTaB63Qd46Wdw7ef4X7j99/2R+4QZkG
         ny3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDDUtaVW3NumxzEMn7pqJSUez0BjYQQtWHGxpje/4Mm57fd0x9mNYKJZmAkkV1x5/PTxgU0seBvw1HNhE=@vger.kernel.org, AJvYcCWXwORBXNJmlZJOn//B5beCvR5PqBLs8rI85NGl2Ig3qsJT+MQ72tGjTqIZrumGjEUP6ahxonSg2+Y=@vger.kernel.org, AJvYcCXi3ayEcOfG99pXsIJnd8JXzpcdu5khluGUDqXUfh68z5a/yRVpMtNEIKWnfmdC/0Z2jo71UJdYEExd@vger.kernel.org
X-Gm-Message-State: AOJu0YyysmYD0tSGrwFnpZVnrVHxWHwzpdqwNKrgAyb+X/vsM5SIMMz2
	hVRA2a/vc7FnQF29xK1yXKxXIlsNDC73tQXyhZvJg04AI7vzzWVaKlhMfjtO
X-Gm-Gg: ASbGncvT2lKI/TQ8afo3MVkpeTxqqIy0EFVHAaQzpFK5tuu/4+urSY+8XsnCyc7RPs5
	4X4nDjJVsPzVRpO1whmKfZJgjRfVL8pO1+fgQXV1vD1BsmQ//ZF/2obA+fkoZMT+yi5z0tJyIxI
	TDxve680du7A9QBdbBnOLCGFE3HWLcyJMPqfyccoyhvEyVqtirdTF3O62PHT0b+mTOz3KgYsrBu
	Zeqpj41D6DeIpmxfz6FFgH6/uI2JWFAdRm94rj/rXiSTT9Ew+PDX6sTiy/9xEzKdT2il9/8V7na
	8inm2h39Qm8QzzWnBhdGta5krItAaJK4OBYrD8BTx5p3Tvt4eeGqXQoHV3E=
X-Google-Smtp-Source: AGHT+IEZe49LqgId3ON5wmec8micMrYJ/QvPiKVtwo4zNx+AQnvppoevZJTySU3BsuxH1cXelRGslA==
X-Received: by 2002:a05:6512:104e:b0:545:ae6:d73f with SMTP id 2adb3069b0e04-548510ed625mr495420e87.46.1740451261935;
        Mon, 24 Feb 2025 18:41:01 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514bda6fsm59294e87.106.2025.02.24.18.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 18:41:01 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30613802a6bso53275491fa.1;
        Mon, 24 Feb 2025 18:41:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGJbWkaTPB4a+fP5QIaLYsnVGWbhzBvX1JSZ5UOZrIIjLp7xn7lUzKQZILYSRb1LaXyFORZJMjfL+Dkrs=@vger.kernel.org, AJvYcCWH/uNkGq4jrDbOrFfCbst/chgD6yJvE7nRGmH3tSVqgVkIFg/ss/GMVgBGFiG5o7i8LAaOGO4+rKQ=@vger.kernel.org, AJvYcCXVDHrJTrnPJyFVHJfzWXUmOSPHCEdoAZNaF5O4JVKYbMPHM2H6lj5zYlzIT105Cn0EaDOdX6qC8OGF@vger.kernel.org
X-Received: by 2002:a2e:95ce:0:b0:302:1b18:2bfe with SMTP id
 38308e7fff4ca-30a80c9a9bdmr5379131fa.25.1740451260110; Mon, 24 Feb 2025
 18:41:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-4-d5e4369936bb@collabora.com>
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-4-d5e4369936bb@collabora.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 25 Feb 2025 10:40:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v64h2znE6KpbWRPWD6ebN=aJpRiOUej82rRefAXoAW1R6Q@mail.gmail.com>
X-Gm-Features: AWEUYZneU2nxWc2oRTXD4Kr8TpvpktBVkE5hzoKA5lPTcw0D_0oTFLZls5e3gIQ
Message-ID: <CAGb2v64h2znE6KpbWRPWD6ebN=aJpRiOUej82rRefAXoAW1R6Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] power: supply: all: switch psy_cfg from of_node to fwnode
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
	David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Konrad Dybcio <konradybcio@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:22=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> When registering a power-supply device, either a of_node or the more
> recent fwnode can be supplied. Since fwnode can also contain an of_node,
> let's try to get rid of it.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

>  drivers/power/supply/axp20x_ac_power.c      | 2 +-
>  drivers/power/supply/axp20x_battery.c       | 2 +-
>  drivers/power/supply/axp20x_usb_power.c     | 2 +-

For AXP stuff,

Acked-by: Chen-Yu Tsai <wens@csie.org>

