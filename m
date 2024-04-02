Return-Path: <linux-pm+bounces-5798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE189507E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 12:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1961C222A1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD215664DD;
	Tue,  2 Apr 2024 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8Vzfiqs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6485FBB3
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054388; cv=none; b=Dx94TmwkXz2GzLo1kK+ysinvbWNQ9OZgslEDNFS/Ysvc2YoRe0WxI7hlxMfn4GITBtKL/W+6qcPN/z1UPtC/z3sis5UZjYv4h8VdlF/R2zO+vSraBxlOkaLrJutZlfWb2Hm0zFRmVUBPcCG8nHo9WjHOs7Xvjd2gBlfwN8J/c/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054388; c=relaxed/simple;
	bh=HhEFB0IGRWmX+BEHDfO8KYBrrkkM8mY4tpZ16mAQ2nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKlYr4w0QMYG9onmV3xZUq73+n/bRZcXkxugM8hDlGwTkvKvlRDUT/06OoR6BoThW13oLuIgmRt4cyY1A66ohdNIf0ufyrmHZKpfKdpi4qQ4Kg73aUhtSwgOGBHjkrU+cAWEgKgfJHV/VZ8LAc1yZWHKbboC2aKE8BjDWE+71KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n8Vzfiqs; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso4249087276.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054386; x=1712659186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+1mQHP/C9wtu+pPXviceegNYIKTTtoExeoBTWfttgk=;
        b=n8VzfiqsuWOr93E0ssGrVoPf/59FBcfuZMN3XmPUEZdGoRrJ4WtKwbJqg0X6vqn7wj
         5c2nPYP3QUagIBWBAGIrXb7rZF5mSmE8lUuedV+tXmbi3iokOFQ/gegSoddd/wo0vAaw
         u0cCCvRjOuKITkzfl05CwtyJm0AQG5T6x3Qg4QAjbq2+p4+i5j8+JXqtNc96aU7UEham
         cjhg3OUgnY7hmoKQdABZtbi5ykfUnD6QtdA4NxeFwyujSU5PkvnNIgBc3B5H6D78M9RX
         OGGrPNILVGPstrLEjpvMc7qN6IPG4FkANwxNt9J/HxyKiEWt+VDBPcQGY0shMNsK4ezh
         n7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054386; x=1712659186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+1mQHP/C9wtu+pPXviceegNYIKTTtoExeoBTWfttgk=;
        b=dIG0Rjxw26Sl+ND1elCQ4fb6j3dPJe/zNtcVLnHoJ5mTKzF19SZV1+qoQxERsRLwKh
         HPJCLNYR2yD/IdgxhDQ0eYWSbrgkW4mTs9DNzXfiWtS4qS0fh3qWb/MMk39/T/8/6Bad
         R/Tqax78V9A7w86bhcX9TsO5aWY02mTxN7XTW/1Ammv75W5fUCJt8J1cHrj02+nIB/Fh
         Uc7oHpUmb8imVX1aY1sTsR7BQdRn4kY8J95IJGDkhzUWYFg4iiXkInzMRkcxWgFS49xy
         Ts1o5iXD6EOlgrJhiIfzGXk1DPQk7QQFNWCytihfSbCyOVk3Kra9Qe6lGVIgJUv9ZM7G
         k4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG9cMsSfMWZ0mO5qRi0/70hnOeuerzV8SpWC1MswpswlnfamrbRxV+QuUwX92gOOsWWYLi68oyhR2rkWs4VCYhfUNPjhb4GIU=
X-Gm-Message-State: AOJu0YxdqXmpqx38jgyRVBFWH77sJwDRYt+U6kYBinxe3iBz2X0ocYdC
	2HHKjTyRoe0k/593+QowoiGMwvAq7RkMQszA1YYjfwDAZhL7NoTmdzQBaSaq8/ODRYGqwWCqgN6
	LCUbw/WZG4UR6d55HMXgLEvQ511xkhgZALzv6AQ==
X-Google-Smtp-Source: AGHT+IFBCL4yjfbf9P6S4J9vEGaxrXR9oX+B1iTse1Th7FUTQ5eAJxtybDGU8x6mh7uftc+KDUharfT5L6xDsM1B8Ic=
X-Received: by 2002:a25:aa89:0:b0:dc6:dc58:8785 with SMTP id
 t9-20020a25aa89000000b00dc6dc588785mr10269779ybi.62.1712054386067; Tue, 02
 Apr 2024 03:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-3-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-3-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:39:34 +0300
Message-ID: <CAA8EJppyuagb5zkP4LCjjJwConw3mw3iS-+dO7YB01=7-waRTw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] interconnect: icc-clk: Remove tristate from INTERCONNECT_CLK
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> drivers/clk/qcom/common.c uses devm_icc_clk_register under
> IS_ENABLED(CONFIG_INTERCONNECT_CLK). However, in kernel bot
> random config build test, with the following combination
>
>         CONFIG_COMMON_CLK_QCOM=y
>                 and
>         CONFIG_INTERCONNECT_CLK=m
>
> the following error is seen as devm_icc_clk_register is in a
> module and being referenced from vmlinux.
>
>         powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
>         >> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'
>
> Hence, ensure INTERCONNECT_CLK is not selected as a module.

NAK. Please use `depends on INTERCONNECT_CLK || !INTERCONNECT_CLK` in
your Kconfig dependencies.


>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404012258.MFriF5BV-lkp@intel.com/
> Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/interconnect/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 5faa8d2aecff..f44be5469382 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -16,7 +16,6 @@ source "drivers/interconnect/qcom/Kconfig"
>  source "drivers/interconnect/samsung/Kconfig"
>
>  config INTERCONNECT_CLK
> -       tristate
>         depends on COMMON_CLK
>         help
>           Support for wrapping clocks into the interconnect nodes.
> --
> 2.34.1
>


--
With best wishes

Dmitry

