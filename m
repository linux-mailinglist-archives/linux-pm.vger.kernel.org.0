Return-Path: <linux-pm+bounces-9294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195290A852
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C531F22D6D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 08:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0026190065;
	Mon, 17 Jun 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhN4LAsy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604D7492;
	Mon, 17 Jun 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612663; cv=none; b=O2broj1+/QA9FaY7fPP8GCnATQfGixx9/Cfbnknd6LXDqIWoXL/CVym69V//5Qyoes3RlO7DuyXhMoAp3m/m/u03XV1J1GXe7bbm2owDf8XNZfNOvEwZy6Mga+bJ5XNAFdMCj1gsgUK8UA2rsNpx74lYl+Jve17MSiS0uD07P2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612663; c=relaxed/simple;
	bh=4PMSWQqpgy9KLTBdJ1z7dLEh7Y62+2GJ2xCLSoh/wE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTC03h1hnW9OlBZNUD4F9A1HDxI4Hsf+y1afbrCysIDbLESYShAkfEO+1Sc4ctlcThPquh6QFkYYlr0eHeBLOgQ8LYKfhDkohsFT3bnXDP8KcWxz2BZyqTuqZqZRLgIhIphxY6bVxDM7FnpuPLP6e3XGyAmunI73j/t8MMmm0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhN4LAsy; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b96a78639aso1622411eaf.1;
        Mon, 17 Jun 2024 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718612661; x=1719217461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9HdCcwPlP04M3/JAPMUtzS+6dDB80C3B57mZ9YxWUl4=;
        b=PhN4LAsysQRcL6wvq7W32/wCk4K+KdPg9e0nObFG8uu5to4e7QA30/qL3OhjqXMVHR
         +GX5Qo164NCiYPVqbKQV/m2oOY6kyoWtIGiNGL7H3OBilwln7nCVogUDbkD6QMPtUxML
         dTcRiFMWYnhd1IlgFIHvvDDfoCTwOca0HhseGS3TU2+XRuC3IyIIGqr6Xljd+QL4MSey
         pcNJoZ/Sub5pk5Hn7rUAjLvrxlMXlrTXsO/GDcuBqyoXw1G7oBP689Gcnw77RzkzSTt7
         SBUGPpL7MiqEKAiktDaXEFhpW8BaGQOnA3x/2KbNjMnGlfpYRUi+5lksxDmji9/QoF1Q
         Te9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718612661; x=1719217461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HdCcwPlP04M3/JAPMUtzS+6dDB80C3B57mZ9YxWUl4=;
        b=K1xmpYPyu6SP1KO5DWV49ehzLJqn3/MKyILzOPhdRtsBcCLH6EyMVVEqo1bepc96G7
         1OJeuXlqMEQCmJzn5kPy7rBYIn/n3wOLWKqgmXQ6yjM1QqF9eBWxQPq2ThCL5Y9s5pvH
         +AStxLSSE4Oz00ExQGRX5rk2ZIblCvD/ye5IvDmCEK6nhLGvJBizmNeH21PgdxguRajn
         j6gXxVY3p501CzbfhRrBJP0By691ZuA67/d5KBHZFNX+/xXJzY2oWNUaEsFQTjhwpHjN
         wiXkoYpORj37CpbFYoi+q+Lu5LC1TUv4PhS4+PsqklFtczdRJTrPIPFXrkrDDq8Z64xO
         x7qg==
X-Forwarded-Encrypted: i=1; AJvYcCX3q79ULvZdK0fjQng7qBVf4NqUMRZFT3rf0sHzGvBxiYLLuRa//J/RuJj8dxdLWzR+MqRH8JcOa+zaryX1LdfjKxNlfTdSZaN0eYbVnYiS6Ad7YStYGKC1HK9vhv56K5e+j25FBo7KyjYOBFrEG0Mk61PqyHrKZ1AMhUBUZCreuGLaxsiCBzXtuw==
X-Gm-Message-State: AOJu0YykWm7489kBlxIac4jRXnRIL222Bl00Azk8YY52j6yEz5SJxso4
	ZFfiuMZeC703xRHpZwjvB10Mdn6LS0AFJBH3jlgyG5Lc9HfzW4spNuIRssKzTELQDqaJxTjYlyM
	fukYwczqT94dAWOWpzDb5Hyb3PKU=
X-Google-Smtp-Source: AGHT+IEXwPAwhOMCvBhbWjRVW5Ubq87Slh/d+RapR7WqMRF0MA+etjIVrc7SQl3B2SvXdsOlXOP+gTpxWIkIi/JCyWc=
X-Received: by 2002:a05:6820:1506:b0:5bd:80d7:1891 with SMTP id
 006d021491bc7-5bdadc8d142mr8246644eaf.9.1718612661374; Mon, 17 Jun 2024
 01:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510094034.12493-1-linux.amoon@gmail.com>
In-Reply-To: <20240510094034.12493-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 17 Jun 2024 13:54:04 +0530
Message-ID: <CANAwSgTRfEChziyys251-FezSevSq9pxHLJixVCAybJhq5YAqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled()
 helpers
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Fri, 10 May 2024 at 15:10, Anand Moon <linux.amoon@gmail.com> wrote:
>
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids the calls to clk_disable_unprepare().
>
> While at it, use dev_err_probe consistently, and use its return value
> to return the error code.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Gentle ping?

Thanks
-Anand

