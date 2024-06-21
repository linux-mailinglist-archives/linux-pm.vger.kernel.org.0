Return-Path: <linux-pm+bounces-9763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91798912857
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D6B1F288E2
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33C364A0;
	Fri, 21 Jun 2024 14:46:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7C2BAE3;
	Fri, 21 Jun 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981213; cv=none; b=sPUdIu60VeORkC4OryXB+yMZIQvLiz9p6QVkeG7mjEvLDdNu+rXyDktuEj5N/EgYOhC6fg716szF4TgdDw4Sy1XBMvMJYs+zHi5JtxhuJdzuOj7c1b+VBnHtu604v3eoWxvbxisB7F0TODV+sk3H7eVBr2uUnxoKC4otqtEBGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981213; c=relaxed/simple;
	bh=yQVb2DeThksBLy1v6heanX+uAjJHYjLCnQz2w0NHRqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmEIBUhjXVsMMl8nmdRcV41bKoNF7nGirGRTCNZy9FsK4AkZI6CY3H7479Oq1StdgDN5y2fIJ3E2hv6yC90ejBeYsbOknPp9/1+wagUI1BPM3IFtbARkrWw1WGfMveaCs351gw0xl1P2XYkjPtbDlActwRFvNb2u/OsesOhB7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso2023884e87.3;
        Fri, 21 Jun 2024 07:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718981208; x=1719586008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQVb2DeThksBLy1v6heanX+uAjJHYjLCnQz2w0NHRqc=;
        b=tQ5sLXnzoPkaSkLZ5Wqt7NISILtrnAxq6fkaJY9T4b7PUG2ZjeIrFHeXKB9hfekJyc
         P8918gYagsgFd/bYldXpPefhRcCO14fzT4Ka6wzXKyFRq7BI6UStt+Vcm6Krq4DIkUTK
         660eiQR+CthCx/Al6x/QssiVC+BYIT8Q04cfcMHYg6WvfcRFWMCUAP5NwmvKhqZnw/+E
         clfdo8gpwFJE+cOUtJ9iRBTkJxx9HU1ETKCFV/y5xqbTnCAfEoQgI9W3H/BVaJ56Fm09
         ne4LQ1t2aEskLDg26V/anLBGwBPQIknxrO7DwF0eQwDroMKJanoIH8exx/vFtCyAF0r7
         JAAA==
X-Forwarded-Encrypted: i=1; AJvYcCVcU0xLQhgIl+Y+Uw9C3XH0a4RA9HEEqgMU2q5G0bSlg0tFkNJr/nHxohUuP31pGL/mwVHTkOwc1tLXK4IbYF+4UrPo4UlK0vJR+pMiNXsfxYTGAuvVmH6HdFLfzMJmLziqTpXuaLUfh8z4jMTmj2pX2DPGa19DksL0TfxVUJF+6e7T44tPlv0yBkOyxu5aQEVdD6M9IsQJN0HlXzlh8Jl2s+Q2LkYMnF6hos2m0m+caiPh1kCkIU26gvp36d8j9GTxWYrQz+HcCKhXy0d3BNX6I/Ka//1IMaZALXqXp/Di+o5h34HuqhBZUBecec1t36R6XyOA/7M7yyPqRQqzDPeE7rhthw==
X-Gm-Message-State: AOJu0YwkNyvdXvfLGvyEDUYuc1kzW0LCCAmhe4/Z2qlhXIH9PMDh/NOc
	3HLSthSXTx1qr1lRVAhCBqhjS/U8dfvLzCZXBmZiyVyOvdvzkJTHXuo22gM/DpM=
X-Google-Smtp-Source: AGHT+IER7wT4R9FfGOzQ5BNfgll5zO8oVJ4SPQG+6xi9r8nDKeH7ziLtYU/BWHh5yJD3VLyT3Eb/yA==
X-Received: by 2002:ac2:5e78:0:b0:52b:bdbd:2c43 with SMTP id 2adb3069b0e04-52ccaaa8d27mr4679346e87.61.1718981207807;
        Fri, 21 Jun 2024 07:46:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdace206esm100345e87.286.2024.06.21.07.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 07:46:47 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cccd44570so2468895e87.2;
        Fri, 21 Jun 2024 07:46:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVr3Wm/MY98z91lj2BJiaYsaP47maRZCyqyfvlJCH8OKjvpALfVSBALIZVvvXSr9Y3QRUut4A3mrmprnUkALNaXApBMiZkE35fsGixCdo0OcszqeWEUkGoCl4LiSPKidpmLgLyy4lzMFAkTvzjR1ANGi5JYPwQr7SMFoJh90SeJcC9TJlfyTjWDtBCTAEasPqcuHGmLxBUKrPTy2t9qA38/3+qLfup2AgRW4uESKsAT9RgrKYRGpTn5/n+10V1bOCMBkrhvxJIYgiiC4yFMQ2TynBfiBOhdltc35NL8opGh9D1j1tQ43eH46PXM01HzFxhDR5lAaXcclO4CXyIVfGVtYG8B7Q==
X-Received: by 2002:a05:651c:104c:b0:2ec:5073:5816 with SMTP id
 38308e7fff4ca-2ec507358edmr10687831fa.31.1718981186574; Fri, 21 Jun 2024
 07:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614-dt-bindings-thermal-allof-v1-0-30b25a6ae24e@linaro.org> <20240614-dt-bindings-thermal-allof-v1-3-30b25a6ae24e@linaro.org>
In-Reply-To: <20240614-dt-bindings-thermal-allof-v1-3-30b25a6ae24e@linaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 21 Jun 2024 22:46:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v65T80TH9HUpny8vK2KNrE6aYQHf4x0CAUrxKWih34TdTA@mail.gmail.com>
Message-ID: <CAGb2v65T80TH9HUpny8vK2KNrE6aYQHf4x0CAUrxKWih34TdTA@mail.gmail.com>
Subject: Re: [PATCH 03/22] dt-bindings: thermal: allwinner,sun8i-a83t-ths:
 reference thermal-sensor schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Guillaume La Roque <glaroque@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Heiko Stuebner <heiko@sntech.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Pascal Paillet <p.paillet@foss.st.com>, Keerthy <j-keerthy@ti.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	zhanghongchen <zhanghongchen@loongson.cn>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	imx@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 5:46=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Device is a thermal sensor and it requires '#thermal-sensor-cells', so
> reference the thermal-sensor.yaml to simplify it and bring the
> common definition of '#thermal-sensor-cells' property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

