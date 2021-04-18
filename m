Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7899A3634FA
	for <lists+linux-pm@lfdr.de>; Sun, 18 Apr 2021 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhDRMEm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 08:04:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:53899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhDRMEl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Apr 2021 08:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618747428;
        bh=UJsT5aV+MxRbho8JhRzNBpNeMbZUN3ULqGnvmwYqqo8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gtWAMLhVANHc5fa/MEW9QtadcRt6E3XfLkUMwhO75vFNJ9hSiCIcdBXyh19j4Glvx
         xlP1dPLK+L+gfju2A+suqWIgK1cDu7nk/k+Hk8vya2JdjeXOowr3KojS5rMCxKfH0l
         k494tuyFNJv4jIqxdj0i2T9ANWf8U/auoWtHGEaE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.75.88] ([80.245.75.88]) by web-mail.gmx.net
 (3c-app-gmx-bap31.server.lan [172.19.172.101]) (via HTTP); Sun, 18 Apr 2021
 14:03:48 +0200
MIME-Version: 1.0
Message-ID: <trinity-93ab11dc-32c6-4e6b-8617-6bfff1a1b42d-1618747428085@3c-app-gmx-bap31>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: [PATCH] thermal: mediatek: add sensors-support
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 18 Apr 2021 14:03:48 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210320080646.49615-1-linux@fw-web.de>
References: <20210320080646.49615-1-linux@fw-web.de>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:NpJG2XS0uVpmsDDBMEbodtzzfxpTnTBa8p1RkMykjqag/W3Gxr2tax05+zGq5AUWfZw8Y
 UR2I0pxvM9MHe0r8VhdDWkgQGBL1SI+8mAdYtMqgypfgy6RLOSe0qt1nK7c6agDFY5PfxSqpyO4Z
 wuBrnzufOyhYmZnoAymsyPyAXn2DXmF91+zeC+t21fCSauEkUxk78mx99SIl3IWAzCGwm7sT9tOV
 qAI+rAIGkZY8+FqJkyyuAffLkkKWZ7AsT6wur+yubLVNmz8hfao5kD5mi04EgQYx2wDkuWpwzz5T
 Is=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I5KzL9OLaQU=:3OPO7RKu+UrbJhyuN6QKpU
 4BFYTNIp75gm+rV0iVvIjAnrZ4rj3UrvsoLuay+pCtGrHP3kS1gyMDoKaExubD2BtRxmnDcFP
 EXKFerqtjTB04wqUrO88LfpaXR73l0pGklAIgozu0o1JwZcj0Umk3S/bG6qd2vhka6gZH3jKh
 qRu0q85YFDxkMoCR6UUPpVEPnVYXeqHPNTdFN37xLgMWQ6okybKiy8tUUE+bUyeT2ZSVPD1yk
 2at67rwVhXuVNRDnpguJsZvuCBq9MJa5fWUHc/BZ4u54VHhg5HH6Qir6G8J48GSr6ZgzVdfWF
 p1FA/423VEpjXaXcAtA3tBTHaZAk59UAaiEn8hsDVE+UUwrb60yU3LAmxv8g0UrhJfDmYHsrh
 Gl4F4Cn9dkJEs266ePIsPs5U8XZ8yIBRtVlm/DYT+Ge3FHzqx90mSDbru7P8Cb72TdhZb4stC
 zb+HotaIeKhlrhZ7IbA57k62MuPtnAjeyawwjbZqzPnkb42UGomNLhwhjTnDyEFNvjezFFpfD
 y5rD4nGv3MbX/iTa+hRpzw5YKZVeCdbli2KhM3KWeQ8GEP5WQaBF9Eruhdvw1L3CE2jyPSMCz
 7K8Icw0Cf8kRzGRPxjMNukY07zv3tUyfUnBba8wMSmmdn8CcArkicuPi0i8/5ZZu5jVyN6+K1
 X+qLouCPOYByILOHs2fiFZVxcieOhdrk4fND/9bOBTRStLouXPo0aYprAGKXFpg2Yw7ZvHxDZ
 xFsPCVLNJE6nY/vdcN3WQViWdSHZK4iqsfTkN1eZUHW0WF2ORC5TDQOELbuapp321t3PbRyYK
 Bw3XYc3GqeMj2QKSR1+0lg4XQnhRLrXuuWUmN0DTw18tK/eZV4tCyn4MnqM9rUWjA178rfI81
 oX9ZfsAH+dh6HQ+BoZgsyLstw8Wrc5NgE3NKpQkJv+j1dSkcAiZcwjlHyVnblA5CKZ7/vcTyt
 VDaQZgQnZ+Q==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

any opinion (except typo)?

thermanl =3D> thermal

regards Frank


> Gesendet: Samstag, 20=2E M=C3=A4rz 2021 um 10:06 Uhr
> Von: "Frank Wunderlich" <linux@fw-web=2Ede>
> add HWMON-support to mediateks thermanl driver to allow lm-sensors
> userspace tools read soc temperature

