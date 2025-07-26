Return-Path: <linux-pm+bounces-31431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA7B12D02
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jul 2025 00:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579BB4E2FCA
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jul 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1C207A18;
	Sat, 26 Jul 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7hH+b8/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5BA93D
	for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569763; cv=none; b=oSZJ0fqHUjYc+W9Znn/7b4vs2spFrw9xEM8sA3NmRpfHVSKEMWSgwKURPJhsASJIMFNR6WBgZLpoE7uo28lYeGqljPqZl7MdkKRoo9kg/6IptOBD73n3KAzS1F2Yd7OIHUkQEORIGz5HhZhT2r8x9oUYGc71zWkskV0MyWVKxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569763; c=relaxed/simple;
	bh=XINjm5eJwbEDX2era1BPiVFLhMPJgaRR4ULKw/oRXFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dgol3PFlVuLBTJ+M06rZ9OJDcCQeK5h3eeseQCVWYLhzlp1cgfHTbdYBcMTONf+J1bqMquzAK4OTkpCi8PVb2G01tOd6Cq/8K3bDAOW2nburJtLQxUgriq5pvaePlrJQL8HRGc02Op4BZSvHw6DybKamNLYb8DY3iLB4RBnlta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n7hH+b8/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b6a349ccso4768472e87.0
        for <linux-pm@vger.kernel.org>; Sat, 26 Jul 2025 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753569760; x=1754174560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XINjm5eJwbEDX2era1BPiVFLhMPJgaRR4ULKw/oRXFw=;
        b=n7hH+b8/7dC6w4AJYLitWZh729dWepk13scS/dDzLPGGzFrfEqA253mmxCt9SaK5ef
         nFww9I29ox0TnEaYdk5IRUVjmYQPpnsTfPMPEz5g64KlzrITtfLvop72kbn9z0R5oKc3
         ZQM9gKKst50e9XrQWhVdNTLk5M9vLf0MXI65KaVIQL9pjXPpGNrnxk9pInbgc7zazmzX
         Y2OYxp8zNSI7m7z8AdFtNJMmlj4tFh0bRgE//jWYwYaPko/I6UWgOpZanC6YUyf0c9Ea
         0oIQjVp1BOTlg19B75FEXF5dRz0on9/G3/7dZ3rw3UAzLPaXBEw7k0JNRJ5MtIjhVuqu
         DV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753569760; x=1754174560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XINjm5eJwbEDX2era1BPiVFLhMPJgaRR4ULKw/oRXFw=;
        b=kism0JuPCmyKkyglQmtZHDbEkW/LnqV0JIx3I9VWIz0rdbCkqfb3svG97Tk67GRgRM
         xQXy3DxQCqFBk8IpSbXgq6hv4QU0GurMi2vfX/H1A7McPWGzxkDG/P1uAC28lujLMPz4
         fKH6mBbMvr0yx0nsvMeX/R1ZGqeR/EzMO0Jg6GlQQasdjl18YraFErkRBLgDRGOM60cx
         xIfh7++m6TVGE2nJQ7TTuOzgPTQD1X9r/di6B8eO3KWIUGLEpyIx2L+FLgY7lijHwU42
         tyx5EUPriolWw1nPeiAL6STRl/IBT3UFNOqAzhBWMr3mLk91af+QtzilWEge5cp4xdfm
         fsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe9Gk6LlRSBfZEWVKMSH5uLRSHJibKu6ydjQ4Zw23fqsl+SP51Soong5eW0PuIFFz+rGq+MRV/SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWKuGxhwVP4odljpBSYEljzsKSjgoZireIGdgMLBKNgfh//1C
	z5GNMjhrSzS4KAjIj9kmxYiiu1/MpWvD7wSBz9dd385nhhPuobktOKOPo6Wiw6shry3AH9Rseh6
	ddpoCRxv69PkcJmN1yKhd1jRUprCLpiDKHkQUIT2GNw==
X-Gm-Gg: ASbGncv17fu+/zuzFPRYl1N5zXHEMUMR7xmGDm4nWLQ2ICPALZKi4KaXB6B57kR0Y2j
	0NzO1FMUotoTFLVECwqGZoam1t0lRn6YhMlS9CGxQLQMAAN8lmDZXKQy6tgVEPiBlmvTe1ET0RO
	TUo8wGBPH64UGUBNFsY8ckbiGjgB9KZXWG8fNaSbDP4TtIhncH0Twlo0zSJFIUcbeELuIqIcLiU
	NZImB0=
X-Google-Smtp-Source: AGHT+IEVawe5Cy8Mdea0EHNi92nFObfRDppcHaSctt2dsXCf2LNFRb76xcYUB3iIilic1skhKmoV6XadZ9gyMyOmo9U=
X-Received: by 2002:a05:6512:10ca:b0:553:2bf7:77be with SMTP id
 2adb3069b0e04-55b5f3ed7b1mr1678883e87.22.1753569760369; Sat, 26 Jul 2025
 15:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721122605.46724-1-hansg@kernel.org> <20250721122605.46724-4-hansg@kernel.org>
In-Reply-To: <20250721122605.46724-4-hansg@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 27 Jul 2025 00:42:29 +0200
X-Gm-Features: Ac12FXxGUIWF8r13EdzumLmWjAGH7jfyqtb14mSNdKuf-GhlQbqAkJi2AgnoTNQ
Message-ID: <CACRpkda0k-Yz+mQL2nNZ=KPQ+4ymZ0KUPjZfC9c=AewKh9mjow@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] power: supply: ug3105_battery: Put FG in standby
 on remove and shutdown
To: Hans de Goede <hansg@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:26=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:

> Put the fuel-gauge in standby mode when the driver is unbound and on
> system shutdown.
>
> This avoids unnecessary battery drain when the system is off.
>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

