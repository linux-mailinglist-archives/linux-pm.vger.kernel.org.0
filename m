Return-Path: <linux-pm+bounces-5799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AC6895085
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 12:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445B5281F74
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70B5EE67;
	Tue,  2 Apr 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GE9/grAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC55D8EB
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054446; cv=none; b=YEef/VC7/G/O178cadC4h52TfaKewgtYnOQ6Ju7JjYy7QtUkDjw6HFoWvjls7zY84xbzJSKJXsxPGtvt750mHxrU6xRSY4rSKsFj3d/GyuA5Bu+xcyafPG2g6wBA7aSwuon3tiO1jpn05t+LXt8yFx8j2lMLDn7uZN/ylBi7O9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054446; c=relaxed/simple;
	bh=UsPusJ70z/hTGNwQRA1c0DtkXeRzoz/bLJ9nq3UmtYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwW8RjJP1pnobj0kG0oWeCKyqvRnVOqVu9O6fCPF5WCSxHpZoHstTpX5J9YxYktYat24NVPN7SZE1GOvvnooQLywfmABC8uDu9M+tLIGfTv+GsYtQ5xZaLLv/5OUOsgmt3JjSXaR1oduMvQYNQj5gXMr6RQ+IgY4Ou/ywBXfUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GE9/grAw; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4620732276.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054444; x=1712659244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9PYIxF4j0xg6PPKY6bKCHDAb7yDnCos1Y4nrGksgbb4=;
        b=GE9/grAwXjS3vyGcP3xO2p7aY4SQE7kknB7whhEJj+RZknboC7Fkvp5M0xLcp1w1YF
         9VpuKcerKq53qlB3n6JQSIHAjOlswb4uYVhXhsR6Ja9wE/rPHMag0KbrooFWPEMq+hLH
         P7hhUzKBJNjEmLbY+0YEbZUL/slxVBYtziKTaXOC98GLtnQuknFdZYcC58bEU3+fj+W2
         IWMHarmeQM/wegnsXs/iykS1bPnSwd1fzwdYT3pVsAfNRgxk2Eitfk8A7n60Oc/8jjkj
         5aK16Le0kSOPc7dZXxF6fxVp/iJlt2UiWq0n4uKZsaqagXfsnZfC1fXvzH/ekK3lzCGj
         xzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054444; x=1712659244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PYIxF4j0xg6PPKY6bKCHDAb7yDnCos1Y4nrGksgbb4=;
        b=YFWogDSCaqkJq5PDN/bNU8lLapa2rs2qXjCImsW9A4k6P+XJ900xSQCwgmLyozhhue
         6ci/IY2Z+RqR7ZongoMz1jR2DzvuV+O9zLhDRFUrv01I1nmpSSdgAfShZ/Zwu3ivPPQs
         hQ+D5nJ5sFaNpEDMlNhG/YHMdhVMn+H9hRLrC6R4BDlG9KnzEzoAHPuOaCvf+wyB4YZf
         vI9EidK4jF+NZyq1Wag9mKrQpx3Antmu7QRb6G65jFsS1PjVO/HPrMv+tTj5a9Ex3Rjr
         R5bPizJvTLUxakr5DkAOa0ablJvckrJJX38QZVZqVY+nvYdKtzyFXPB0/Vrbo5kXsB5I
         3pBg==
X-Forwarded-Encrypted: i=1; AJvYcCUytQChav/qpNNZm4zgU23plfKtDyZ1J/ne2eiZrKtlYeCPz0507mUOPWAvEXd6chNTwN86uBrNLGTRvkYZntGLdJWvqXxKf+0=
X-Gm-Message-State: AOJu0YwitxE3Lhv/f58L/C1VflSsylni8UJc4nbCIQI5Qn/P9igLsdc0
	zfy4F/mwRrj5vv70bA/HOiLcLslFdDbhE7J0abcqQ+slgV6h1X/EDifs/Ezp067Gk4LxyKNxQ7F
	J8QFn1KbToKCRJYVUfYUN9HZzfOOgew8xmtZ0Wg==
X-Google-Smtp-Source: AGHT+IFJm9l+G9UEBddm5xRcgxHteNtcPg5V78UGOHmM+aa84AtnvwUHGqb/sEXQfiCIWlOZaAm0r9DYyPYH6p7uu4g=
X-Received: by 2002:a5b:ccc:0:b0:dc6:de64:f74 with SMTP id e12-20020a5b0ccc000000b00dc6de640f74mr9783364ybr.9.1712054443883;
 Tue, 02 Apr 2024 03:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-4-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-4-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:40:32 +0300
Message-ID: <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Wrap icc_clk_register to create devm_icc_clk_register to be
> able to release the resources properly.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Introduced devm_icc_clk_register
> ---
>  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
>  include/linux/interconnect-clk.h |  4 ++++
>  2 files changed, 33 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

