Return-Path: <linux-pm+bounces-16900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3759B9FC8
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2024 12:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CE4281941
	for <lists+linux-pm@lfdr.de>; Sat,  2 Nov 2024 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6235189F2D;
	Sat,  2 Nov 2024 11:51:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366C189BAD;
	Sat,  2 Nov 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548271; cv=none; b=mRfFckqTVKaEAiGXvJqWD4khzd1wONdxhd3SSvnn9pA6yEG9KJM2sgW4B0Di7Ybo9p2kalGsqn1rxc2MbcqyFw9GLr5KQglqq/qWmL27Yghq0jsl+OQm6l+8ddJpTgHsHe4r4AtYAlnrL0zig3Wxgy3HB1pTLaAcUB74Tn2xDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548271; c=relaxed/simple;
	bh=MtCxFhn9qQLXFwmCIV0k0ztAlVpN8badYhBgaQ4qWME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujgIkNIQWLXO0ydhLjNf0qqmASMGGmAduaZ28ZMWv1yuA2gsiimV5/QAAJukzoNEaB+21yXLfiOCNdVeIQcSUH1I+Ja9tcTOeonEH0CjjIWG3fjTa8kypi/Z4QYKDYZrU7Cz71exwrwtRe0pjhyc2/6qT0eoBfdt8kK6/YFmOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53a0c160b94so3109236e87.2;
        Sat, 02 Nov 2024 04:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548264; x=1731153064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNxx58SAnxfm8WutwLtZrpYz0UwbZu8UhPuKwFhJ2Po=;
        b=DwBWKS6thXXlhQEdRmebtkglceD/c99oMau/Bw4xwyMei1XSH/54E7C8c8jw0+HFDi
         X2KNh6etXrhXRJwGHUmyaXvtdtVF73LFn3k+561P2qRP3kKqpdBxfqsb2YsT3SwCe1xl
         MPJVc+o2UArG8DJ1YAwvIvOzriFVXh40P46RDaC67DWug6hpLcZtLeP/7+aBu19KVl8K
         j2JbjqIEhyFjoJgMKUQTqDtRKHNcyLedYHhm9VRqhkW0lFaJcOZoj1S8WilckZlz5exE
         Hp5vbRR3NMP2yfGvhhOTjS7IpSeU4iKb8IoTd3ni44cboxvHdETejnTD3pjU6TDo45o+
         YLXw==
X-Forwarded-Encrypted: i=1; AJvYcCU+K7X2VaJp8YgitOduRWOBYYSXPZEt+xM5urV+qYqyphJp9xhQPI+JoR51tSPGzTXtZjtgg9wGP7w2@vger.kernel.org, AJvYcCWEm3Vgs9SlLoXVwXADHVlmpIZnG/k3QayzcgTi/9t9AEavrfzDcye8kRY+Q7XJK20y7P4ceNbipjY=@vger.kernel.org, AJvYcCWjlk1+ZFju8ZehQKdGWRYBJbaMuthYMojOf4fNiFVNbjVi3rJ7EAg9IFjQnX8XyQwNsCO+dBNdsgD8klN2@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl47e2HMi1ZGMiECQ0DteQo8josuvH+z+yqViGUhDuEFHk+a/
	py/eKtc5mLiRu4AFTd2pyMdA9Nx508JrYyDnWiqH0L1YTtxkZaeLzknC9jUXYnY=
X-Google-Smtp-Source: AGHT+IFYPUyOL73IeXAWNld6qeXVFY+7vz1m1b2czqCVMh2g+Fg0Mhswfl3Uu2RLrW+V4zlJ1vGinQ==
X-Received: by 2002:a05:6512:2315:b0:536:a6c6:33f with SMTP id 2adb3069b0e04-53d65df22e7mr3182705e87.13.1730548263610;
        Sat, 02 Nov 2024 04:51:03 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde0a53sm879228e87.262.2024.11.02.04.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 04:51:02 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so23045201fa.0;
        Sat, 02 Nov 2024 04:51:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbliltb2C7b0J4cknxYAW9P1XSzxOf0uJbDNF2IBT9g02ZaNhwL9iICQ9PDwV9VXv30cZpe5XBgcgSJshn@vger.kernel.org, AJvYcCVpGdWXHMeQn4M7sjZYGznYWkLoNdW2udCnKDzQNyPaXxKqCEK95OOy7fNIIUjgHACyCvQWcRTfuMo=@vger.kernel.org, AJvYcCWaCliN1ZuKs3Y4WIB+MH1SLW9brW3JHl9MtlCa34bcbphl5o5E+luzQe45rYPTLQSYkJDYnhCxgryX@vger.kernel.org
X-Received: by 2002:a05:651c:247:b0:2fa:ccae:d1d3 with SMTP id
 38308e7fff4ca-2fedb7a218amr36689791fa.11.1730548262188; Sat, 02 Nov 2024
 04:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest> <20241031070232.1793078-12-masterr3c0rd@epochal.quest>
In-Reply-To: <20241031070232.1793078-12-masterr3c0rd@epochal.quest>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 2 Nov 2024 19:50:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v64BtnCTCHnqpQrT=c8XRpr8UtpLK58DrWd9gv=tJjPHdA@mail.gmail.com>
Message-ID: <CAGb2v64BtnCTCHnqpQrT=c8XRpr8UtpLK58DrWd9gv=tJjPHdA@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] dt-bindings: opp: h6: Add A100 operating points
To: Cody Eksal <masterr3c0rd@epochal.quest>, Viresh Kumar <vireshk@kernel.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Parthiban <parthiban@linumiz.com>, 
	Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:03=E2=80=AFPM Cody Eksal <masterr3c0rd@epochal.qu=
est> wrote:
>
> The A100, similar to the H6 and H616, use an NVMEM value to determine
> speed binnings. The method used is similar to that of the H6. However,
> the information is stored at a slightly different bit offset.
>
> Add a new compatible for the A100.
>
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>

Acked-by: Chen-Yu Tsai <wens@csie.org>

I assume Viresh will take this along with the cpufreq driver patch.

> ---
> Changes in V2:
>  - Fix ordering of compatibles
>
>  .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml       | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-op=
erating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50=
i-h6-operating-points.yaml
> index ec5e424bb3c8..75ab552f6ecd 100644
> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating=
-points.yaml
> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating=
-points.yaml
> @@ -22,6 +22,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - allwinner,sun50i-a100-operating-points
>        - allwinner,sun50i-h6-operating-points
>        - allwinner,sun50i-h616-operating-points
>
> --
> 2.47.0
>

