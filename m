Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C099F755
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 02:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfH1Abr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 20:31:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33241 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfH1Abr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 20:31:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so492090pfq.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=6DZabq8OOFr7SZFMrBCsezS6Py1mMQ+cwU1PePGAkIE=;
        b=ngcmAUYZXtJo08EKY/VBWkbR9Y6m5d18wyRsXJer8ur7SxM9k+agOqehuEdH+Ycfdy
         Pi+EmEsEwOnOxG36KNKWz8e3uqLo+w3XInaErt/dXflVRpust3rsqo3sHIA5aMTfgf1p
         +Mc9OLlWFa+tmIaaicyodHEeYt7jVea8ulCTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=6DZabq8OOFr7SZFMrBCsezS6Py1mMQ+cwU1PePGAkIE=;
        b=sN97a1RW9gOrUNxzgjzNsFQCySGDgWKW8PTb0gRFH7SJ9LzA3jaA41JOUagvLxRr6M
         MwtFiLLUOwjeSG+SW585QlsjkX5II2dMpuduWkcH7EY2q6/GEfcmJPpQSfR1PPw5aK3P
         1iiVlxrkCZ/7dyJc0j+V4hx07EMqIfFW6qIkNqsPo3ybnN7SEa0S2oCzGo+ahiQDbGul
         LI8MglRnMOOT/ZecTvvC+HB0KCRqTUUrj6pdZ93qOJST0fPncmD55QQAOzV7jU2yeCiA
         ek9Qzg9zXbqakd829r9TA+2d8dKJcZrC8m18SQ4505H6Z9mrz5yqq+bH5oX0bvHRP0B2
         yz9A==
X-Gm-Message-State: APjAAAWo80NaKVL9Y3gbOSnlpoOV12/x2DxLKtHu2unZpJ4FZO4OMuCL
        gSbEdnbdZwnlVSYi56gwYRvUqCuQPoOkcA==
X-Google-Smtp-Source: APXvYqyTAY2DIrm/6oafpYk02AMmWsUOJ5l6X62U+poE3/LzEAZrdfqAN9ZcibbeX1gFo/FrO0+5rQ==
X-Received: by 2002:a17:90b:f12:: with SMTP id br18mr1374786pjb.127.1566952306919;
        Tue, 27 Aug 2019 17:31:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a6sm508542pfa.162.2019.08.27.17.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:31:46 -0700 (PDT)
Message-ID: <5d65cb72.1c69fb81.5472a.24f4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f41f53a77406c782042c0a27c180c99859b0673f.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <f41f53a77406c782042c0a27c180c99859b0673f.1566907161.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/15] drivers: thermal: tsens: Add debugfs support
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 17:31:45 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:00)
> Dump some basic version info and sensor details into debugfs. Example
> from qcs404 below:
>=20
> --(/sys/kernel/debug) $ ls tsens/
> 4a9000.thermal-sensor  version
> --(/sys/kernel/debug) $ cat tsens/version
> 1.4.0
> --(/sys/kernel/debug) $ cat tsens/4a9000.thermal-sensor/sensors
> max: 11
> num: 10
>=20
>       id    slope   offset
> ------------------------

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

