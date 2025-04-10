Return-Path: <linux-pm+bounces-25116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD73A8460F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 16:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51942189BE68
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C5728CF45;
	Thu, 10 Apr 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxii+48q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B942853FA;
	Thu, 10 Apr 2025 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294506; cv=none; b=fjBRZlgSSdHcdgKTxTuzyyBdyEBLe8Sy44cUVj0ytwNc0KRyj7b1bkOxnVkMdDXG2l1jrqSS7o6UVQX7rMe7xRa76wUXgFzQizSEvlh20wr4CUQL8DSEsdPRN2zb4Kd3QguVqLkvl/M3uBLJtAprE/xUnIN52iUNI35QtSg0FmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294506; c=relaxed/simple;
	bh=dEJNfddFbQgqgZyZJMMbg8KFOtcsawhyLbrR4L0XzlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+qGAqDhCUEWhsDda0iy2xkpH7NoI1JHVmZVMEZTjfP0aVth/SDoYF24Qqn2nDa2zjdwRz/VZRjbGkzGRDvlNvXZmFt43ElGtrS+0395Jrl+0PAdyMXY1+MAUnnChxBUks9N5ZAj3gQ4lN1U1P3tl8qnMLddyPkdSkPYgc78xas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxii+48q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5643FC4AF0B;
	Thu, 10 Apr 2025 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744294505;
	bh=dEJNfddFbQgqgZyZJMMbg8KFOtcsawhyLbrR4L0XzlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jxii+48qL50pjdA7yqa78xcRpLVZKm5MG303M4J57PrxoYaKv2uhKXslZyLpRdn2D
	 s9Sv0b7pjKAomdPHquiYzoYa70yZ0/Ebgu6XrENWvfOhrkxdZvdApSz0IOXALevVdE
	 zvIfIEuQLhPC/wboYB4n1LGvsTJ7jEVwvnmoxQ0JZH/anv5czFd2INi0HmmbYzo5oJ
	 lPC5IcjIWbucKZmZ6YZW2MXP+d+JYFdnJqM6rRCnvCU7ECeNQOnzgEZ/zTXSusl5ag
	 /YNqtCkozcdHsvO+gZIRaAOzgBX/kI0M4nL2HLbV8vX4KsK1YaHDXhFpwI7IAjxHwE
	 29supMGICfJgg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so1180060a12.1;
        Thu, 10 Apr 2025 07:15:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL1igDAIQ0O+7upn41lfzkdytKIK01us1F74+2wUBEL5FOzoEM7qYPdU7UTkc/8K0xClU2ZARjJNfBwyWvLA==@vger.kernel.org, AJvYcCUkrdP/X0zQy+7rUrYtht5quAdMMWlPbBXy7WlovcqVS2DIc68A+Tc1rGSE6J2zavZE+T1X3XM20klbMKGZMG11fJY=@vger.kernel.org, AJvYcCVDkfPhZMwmJXgspcuzvy8lA6jqosoEvT9ZQNkt0QA+S2wnpHWcAno6IglvLSkrxHmyDMgQVVfSXbXFrw==@vger.kernel.org, AJvYcCVdovAHdlios3+b5h0sf2xHKItrj1IXMlh5DJeF4p3VT5QzdUB7Y2A8wZ1CgZpR8Rcr2WhriQYDRNU=@vger.kernel.org, AJvYcCVr6LQYfhW/1J8aNesH0qWtBPBpnwyTbVEDoP1HVG30GnIfzYBKqr343lgGrERXqehzU2/ONAzRaLA5fOJy@vger.kernel.org, AJvYcCWylW1bLeubWP6Sb2RNuhWgBr2C8EmauEat+blY0qGB/GzFbrE0swIxQ2xvHiGhj9YnohIBtWJ8FNE0@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2zPjddFTi3CvuvY+2U1rztSZ3SOAOSqRBNMS1xYsbO1NiCdH
	dmWDAGoG8Epkaoxd00j6ndNbR1TX3dto9iCclQ7cpJyn63Y5ryZN4t8YAiexJSdeeTay2sQoE5k
	GeTQMXF5n74oAi9ulPgHHNHo4VA==
X-Google-Smtp-Source: AGHT+IGl0fJE2v0I/oCPQTdxQfr3609BfC3sI9b3/3//9E+h8w2umLSUMiDkAMTe1571fUmkVBDDE3jtTLXPBwQHP+4=
X-Received: by 2002:a05:6402:13ce:b0:5e5:dea5:3eb2 with SMTP id
 4fb4d7f45d1cf-5f32c45032bmr2461434a12.11.1744294503824; Thu, 10 Apr 2025
 07:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org> <20250408055718.4azlqljvo4qxhnu5@vireshk-i7>
In-Reply-To: <20250408055718.4azlqljvo4qxhnu5@vireshk-i7>
From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Apr 2025 09:14:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJyi=sR9jtEy9_U+RLVorvZRfby8vsWP6sXV+_4NP+Gug@mail.gmail.com>
X-Gm-Features: ATxdqUHPmJEIuVKadhgZM7F7MHPh64iWIlM7zDUhgEaB8t8IKqn3FRU8YxuohGc
Message-ID: <CAL_JsqJyi=sR9jtEy9_U+RLVorvZRfby8vsWP6sXV+_4NP+Gug@mail.gmail.com>
Subject: Re: [PATCH 00/19] Arm cpu schema clean-ups
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
	Conor Dooley <conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:57=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 03-04-25, 21:59, Rob Herring (Arm) wrote:
> >  .../bindings/cpufreq/cpufreq-mediatek.txt          | 250 -------------=
--------
> >  Documentation/devicetree/bindings/opp/opp-v1.yaml  |  18 +-
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

In the future, please consider acking the 2 patches rather than the
cover letter because 'b4 trailers' thinks you acked everything.

Rob

