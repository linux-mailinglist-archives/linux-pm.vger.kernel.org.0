Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21A41652B2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 23:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBSWu7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 17:50:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41134 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgBSWu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 17:50:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so826229pfa.8
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Xh6W34n9HHMOfDliHp3g0le7ud4E+I3txQ2gklhzxOk=;
        b=bCKtFioU0ZNVBpVC7nZcSTqgaaNvHvJ2QpHQdlE/GfbNy3c8wRephuuBq75QqGh0/6
         q8ZQGdTPtH1u1buLb4yZl4C/QP5LjT6cKqdK4IXTqAIcq/fItfJfWEKIWJMwXwIb0d8s
         WDs77G8E3jiZbo17nQcU+jse967+Fp52qjunk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Xh6W34n9HHMOfDliHp3g0le7ud4E+I3txQ2gklhzxOk=;
        b=fLvOcFs+tEQtahzPIjkKVhONJkQncS2okk5XQyaQzsOkmy5KGIRXqMQO3EunURp0rE
         5WHl+t8ykY8LC/tEzWuIzPOxDO5BM48wryFUPoQiTjL7Ng1PUEz0FaLjLP62eMtsiSmo
         rxrXl27FuaicEU02oVg2bp0BV9rqOnxZleYMydfBsOxyqVswnC4gnsr4X/faz8uqbDOa
         bVTztOsrtGD0eRJy/EnIsvW5xjVdRjJRQk4V2GDI4Q2/FrcDCx0X/aDzIUrL7mOPaOWk
         uxm/6ad4Tq4NzizKhNsJk+k7/1JLVmdVB39ZmnKYDea8EVSx7ezWlnShjOD9WMmRpw+k
         MdBw==
X-Gm-Message-State: APjAAAXqEKe6uylEIVHl/ixPnEfMMUWVeNIedhpPIm993T0e7tolFlMx
        BZm3oGndDpQkAxr3Kr04oz0l6A==
X-Google-Smtp-Source: APXvYqzC8A31lbSt2qHC9NJ+UENq9WfFlFJtzZY4ubDomuJM3gpEnKkV0tUtyrvaFFnQZZ2ZEjwOMg==
X-Received: by 2002:a62:7b93:: with SMTP id w141mr29774758pfc.226.1582152656638;
        Wed, 19 Feb 2020 14:50:56 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q187sm642475pfq.185.2020.02.19.14.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:50:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d3e1c0f148d46e395a0886d9028df0faf8e9f9bb.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <d3e1c0f148d46e395a0886d9028df0faf8e9f9bb.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 8/8] drivers: thermal: tsens: Remove unnecessary irq flag
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:50:55 -0800
Message-ID: <158215265508.184098.6650576617736440661@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:12)
> IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
> property. Remove it from code.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
