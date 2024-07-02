Return-Path: <linux-pm+bounces-10338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752C923CAE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 13:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23442B24627
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406615B546;
	Tue,  2 Jul 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nA6Ci9oe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5D15B12D
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920556; cv=none; b=Z8hD6sQx1l6OYsRYa5WqxRpj+ugNHyTQtkKQSkbugXtH7qaV2mg36+vc5NYUuAS527Ru7j9Vb9WSkYN4/FjdHGEPMN3FbOazUwYCj1VNTLRhkjO8Ivv/IufNJExsMuB4e5eLXn/2MxPKSjlNPnPJ0Chkg24JJAe/V36RzsO685A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920556; c=relaxed/simple;
	bh=stJcbtxT7yyrwVYdqwgWogSdm6qD1il/DBw/nn6ktzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cts4kQ1lZhrxj2QQm966a6Ktgir+6yCDc8SwBZN9X6SdCmcriawI7Chr/FvGLYab9Q6YVp1yRY4aafZa9iddd0vIC80tE6Pm1AQShwiGNOqtrmg8kAdQLs/skJaPPpyVG8aDDqgirkl41k2KRdlsnfnnjoqVMkj3WG840hbzlWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nA6Ci9oe; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64b101294c0so36254017b3.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719920553; x=1720525353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pX0GvMcRUI3OW9Z559DCkuHQ4F+ae0/fRdHiHFHzZb0=;
        b=nA6Ci9oeQ67B1kDjqeGe+j1nHmeVOTBj1kCRBBjrPwsUvhrAJxzXy0YhN9M0oIjdp4
         en0EVsWoDltKwY/hQJ0KqsulmMQmfmpRv7Z2XX+cT6VRMZuc/N72L4WUIFzV7abnn2Br
         j/pQRKqRYe9AoW3LHEwqg+wQADauAVWQ462vNiRa/D53tlWaVhG9vYl3FcxCKWfGcxdo
         MjnjssYuCWjyX7oFn1ahYnnOe2nWWOUIqgTr5ZnzJSNgkHud6PKmYpDbBkg1ncNkzeJc
         cE6yGF9eFdM3JyfDJwTW16MMCHgw9KT+6ByXCisNZDmJUqGzL1IqEhRUisIqjxA0zcOp
         +9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920553; x=1720525353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX0GvMcRUI3OW9Z559DCkuHQ4F+ae0/fRdHiHFHzZb0=;
        b=wzfRXEQ9wR6F2bj45c2VpYmUyTNQw1LGzKnivHDooSbWpd7U/9fOwac6nXqz7IrM+G
         radQopsbuMgwwhPPNJCDpE+O4KpYIwF9mPzv6rwxkQwrjGzj4MloTySO8ScuiCcNeZHc
         hhQYMfoBMOkTCO6dylg9V+wH3tYzgj4qWfUPJPEp/tYUfT3RKq0dEKt+5kpjGdSK5fYn
         bRSf4MrFTuddMsDVIuQ5FxJvzK98/6TziEGcrVb27u652YXBEqzHU6M8cSPn5ee53ilQ
         XgzotYME5yZjV3Yd7uBNANvlaNj+BqfW6sqWpvUA9ibooXSQSLhYZPkNpnJADnt+FB7f
         cFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgKe+wyGLzL4NulSpipBLv54iZi6WB1f9VAlMGgQjQstB5mXeZXTDOr0omi1F9GZ5rQypTu5NB2kkn7MKGcKUp87TWG5iYM8U=
X-Gm-Message-State: AOJu0YwgX9dTt//Jo9nFcrK23+dvZ4RHJZfZc6JPxwRUGGEwIm0X9wxA
	JuH4n6wbWOe+2fePsQZBWyhjQZdbHjfs+JPdsb1b87qwRycRn68zWP8ULKi/gwHH/6yY4HDwnWo
	SqnmDUmr/hxobNud8+ycs36UYXdlSMlqsmSDc2lJkA8uxw8l7JLs=
X-Google-Smtp-Source: AGHT+IGKIwMQNOouPbZn2q3IqAFIf/rtg0qaLro0RVo1YXr4lVNA2E3TE7V9cXqXjNJ2o4Kc815R+yVyKfuYAR/XlYU=
X-Received: by 2002:a81:a50a:0:b0:643:fd49:2db6 with SMTP id
 00721157ae682-64c7123b008mr91387297b3.1.1719920553049; Tue, 02 Jul 2024
 04:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702114103.16068-1-brgl@bgdev.pl>
In-Reply-To: <20240702114103.16068-1-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Jul 2024 14:42:21 +0300
Message-ID: <CAA8EJppo4X1KmeeTRz9n7+9S0fGWE4AD1O1cCc_aPHTWPUGVvw@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: don't request BT enable
 GPIOs for wcn7850
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Amit Pundir <amit.pundir@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 14:41, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Due to having many existing users of wcn7850 in the kernel, conversion
> of the hci_qca driver to using pwrseq exclusively must be done
> carefully. Right now, the Bluetooth driver requests and controls the BT
> enable GPIO and so the PMU pwrseq driver must not do it or we will run
> into problems depending on the probe ordering.
>
> Add a flag that tells the driver not to request the BT-enable GPIO. We
> will remove it once the conversion of the Bluetooth driver is complete.

This will not prevent the pinctrl conflict if both PMU and BT devices
declare pinctrl for the BT_EN pin.

>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>



-- 
With best wishes
Dmitry

