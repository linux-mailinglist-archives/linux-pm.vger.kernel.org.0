Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1B1652C0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 23:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgBSWxa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 17:53:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44722 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBSWx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 17:53:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id g3so845175pgs.11
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=AcediiSivT+LWqDEtOSOEIb/ql/h3th0iLtIJJddY0A=;
        b=BCbh2aaODXUOMbJ47FYF0Z3q9D7rmjUO9/HBZ51aFQnoqI+xQZNeZTl4dktydUcZO5
         mfuB+gNhVU3QidqaXo1cEkR9P6QUPcTUycelJSZTKfXGbYQhspJ+EvcjDHoXBiGZuk9q
         e9xQE32LTHEKzSITdQuKrTMmihiSSub4Q4KM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=AcediiSivT+LWqDEtOSOEIb/ql/h3th0iLtIJJddY0A=;
        b=rjmF+Nq/KFRdcFKdSVPo1TDN9GFdeRzmeU5wUtPuPJVTK4azoUEHE8Zk0KeYG+sQDg
         FLBjtF9XSK+MsQHXbDoJB23Fqb+5/943Qm2W5OT7g57v45Pv5hzrVhnXNEQzd2imJWPj
         vkOEm8NS/HKKkm2eurJosG8+xx1JJGcbQBGPAyr2FfdfqplwO/ZFOXVIBRM4LOuE/jeb
         7gwvx/KkyknJNU8nhYYRUrrJzMkBHiV30lwtyZ9wLCxY5mk1B8+L6SCMFOJdqTwUsQ51
         RUkcBOQ0SuCbQU0okgshoerln69SWMHUe+Q9Me8NO+ErO2Z4ldrSpEg0Enb/aRoO88BO
         rTGA==
X-Gm-Message-State: APjAAAXYvT0oZ7Y4UZSHudNmq+6cT7rp0lGmOnwWr0Ltx/958aFVmN0x
        fPd553O8TVt/APZzi/N7ZfZ0NA==
X-Google-Smtp-Source: APXvYqzgVogCk4wmUAOqQEW4bVutbe6o2CYTMqBsdOfoHwfv/G7oBszdNXPvfuE9X4po34XTi3SYTg==
X-Received: by 2002:a63:c30e:: with SMTP id c14mr31594137pgd.168.1582152807989;
        Wed, 19 Feb 2020 14:53:27 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h3sm845289pjs.0.2020.02.19.14.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:53:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6f95b3f0d39433c7e6b01094bdb200a7ac8e9f0d.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <6f95b3f0d39433c7e6b01094bdb200a7ac8e9f0d.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 3/8] drivers: thermal: tsens: use simpler variables
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:53:26 -0800
Message-ID: <158215280660.184098.15487361696633323314@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:07)
> We already dereference the sensor and save it into a variable. Use the
> variable directly to make the code easier to read.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
