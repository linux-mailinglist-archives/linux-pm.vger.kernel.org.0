Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D51652B3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 23:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBSWvO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 17:51:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43864 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgBSWvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 17:51:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so691614plq.10
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 14:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/C/96K5oLYn6X+y/FSyD1yv4KOr+6D8nD+8tPOB3y0Q=;
        b=L9RxT6F05R55DW31tM4Z5gEB7dV+9AOuoO5r5z9ceAqqDfiSEL/104dEWIO1iraFNT
         089InYs24GWN+iGki+xKDf1BTG0dSNtUruxPvMiJrcIwPvDHxtP43v9EyTIvZdcrcuUu
         HRRYVWm7Ddkt5nek6SrdQonpS/rCmeNVXpdUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/C/96K5oLYn6X+y/FSyD1yv4KOr+6D8nD+8tPOB3y0Q=;
        b=tOQNY+V+UTh4r6wAp8T3oIKcPGot72jug+38j1A/NzewPuElhaxMCsrQ60yUnit2rz
         NANnOWuekZqMW9p7m4nZVZkp97Q1JHoVh1E/gj004UON0m1k3oB5qJFihFLEiBzib34U
         uR+sUJKioqjnKt3w/+PwTSJMU+LJqJbi4qRw8ci8hFa2yHV3Tujr7MlNfExiKnw7eWoR
         wdWLpiZnFaMknbBMTH8UG4TH4iK7bI6c2r5V8re9kQqZHMBGs8D9edDL3iVOacQuMcPB
         TjPef13CaCOHPw9BBAFlRQOqrK/Qp2zL02QyRulLvrUqk0338/F+QTaACZzzqDoC37FH
         KhqA==
X-Gm-Message-State: APjAAAX95X8HlP7BWMDJJSGYEzyX6tb0KHRLUqn0BJzT3jO5/QSyN1Fd
        LDVR9jcXN5nlVhTK7QBt+4dCDGYA+F8=
X-Google-Smtp-Source: APXvYqya2k/fNH0PCv1YhT7xUIMf025rMaROJHmjvNV8yKGJHvlsVKCJayU+6UxVpnujNIsc/SR0KA==
X-Received: by 2002:a17:90a:e2ce:: with SMTP id fr14mr10935860pjb.99.1582152673231;
        Wed, 19 Feb 2020 14:51:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k9sm808496pjo.19.2020.02.19.14.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:51:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8990f5cd5ec2bc2aa0f13c0ad5cd41b8d1a5632e.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org> <8990f5cd5ec2bc2aa0f13c0ad5cd41b8d1a5632e.1582048155.git.amit.kucheria@linaro.org>
Subject: Re: [PATCH v5 7/8] drivers: thermal: tsens: kernel-doc fixup
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaa@codeaurora.org
Date:   Wed, 19 Feb 2020 14:51:12 -0800
Message-ID: <158215267200.184098.11619305318344159345@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2020-02-18 10:12:11)
> Document ul_lock, threshold and control structure members and make
> the following kernel-doc invocation happy:
>=20
> $ scripts/kernel-doc -v -none drivers/thermal/qcom/*
>=20
> drivers/thermal/qcom/qcom-spmi-temp-alarm.c:105: info: Scanning doc for q=
pnp_tm_get_temp_stage
> drivers/thermal/qcom/tsens-common.c:18: info: Scanning doc for struct tse=
ns_irq_data
> drivers/thermal/qcom/tsens-common.c:130: info: Scanning doc for tsens_hw_=
to_mC
> drivers/thermal/qcom/tsens-common.c:163: info: Scanning doc for tsens_mC_=
to_hw
> drivers/thermal/qcom/tsens-common.c:245: info: Scanning doc for tsens_set=
_interrupt
> drivers/thermal/qcom/tsens-common.c:268: info: Scanning doc for tsens_thr=
eshold_violated
> drivers/thermal/qcom/tsens-common.c:362: info: Scanning doc for tsens_cri=
tical_irq_thread
> drivers/thermal/qcom/tsens-common.c:438: info: Scanning doc for tsens_irq=
_thread
> drivers/thermal/qcom/tsens.h:41: info: Scanning doc for struct tsens_sens=
or
> drivers/thermal/qcom/tsens.h:59: info: Scanning doc for struct tsens_ops
> drivers/thermal/qcom/tsens.h:494: info: Scanning doc for struct tsens_fea=
tures
> drivers/thermal/qcom/tsens.h:513: info: Scanning doc for struct tsens_pla=
t_data
> drivers/thermal/qcom/tsens.h:529: info: Scanning doc for struct tsens_con=
text
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
