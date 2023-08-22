Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBEF7842A9
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjHVN7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjHVN7k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 09:59:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEA1B2
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 06:59:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51f64817809so263280a12.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692712779; x=1693317579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlykMT9JoWcf/sLy2qWvyrePtaaIp89hdU3bRhqs3p0=;
        b=hg9VV+h03G+aiVDnkfs+Ftfm9CigvmkwiY3zwi3SC5kESHqfNJUCZbyL5X472qQxzX
         u3vf5HA43tVpvPbY1f6oP39oGXmlB83ECcXZOSeEgOVEGC/PQ79P2Vs9TO6joRWMgdDn
         hcsLZchk8D56MXBDzvvAaTmfKG3MEunlBZBfsKXLiCP580dYXQvaBi0skAmeL8Eoxti2
         6ekOF7nzEbyqFjHAJffIPmMRqwDgSrq1KlpQ8iOqEvhY7AF20a5Z1B0TgcAII2dp1+kk
         j/fE47WYOfvMewi0oMU22nxWeJ3xD8exzqPhi41KQrA6vbdxtkqFPnDQJo7LWxYJoizN
         f5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692712779; x=1693317579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlykMT9JoWcf/sLy2qWvyrePtaaIp89hdU3bRhqs3p0=;
        b=jdypvidIDJgRGg6oDWH8IfvKzVu85vUcGWNdCEjh+zKNf3HqaAlgEyvFafwN+OV9Fe
         6uR3JItlaWOoV3vaSdYuA2+mv0i5+SWxIm6xHbH3c4zEWFs22Gy0nwg49yL3vwnqpPd1
         KIZPSxDkjyVOzUIwAow7gkaMcXj+qk5h/zKH1aPhZb+sWh3eGOig1xy+/feYo1WBJ8kA
         qiPJ+PXfjgMFQd7CBxF1VVTR54faI78jq1DUqaH5XcuxoeAy5Pe/JneRAJy1FlQYhoP9
         4sxauBasHb8Cppp23wbU1EsJjtSKFo60ykxHkOdp+xJEiFSqO3DqujoVhKQnR2aKNrS1
         Xiqw==
X-Gm-Message-State: AOJu0Yz5EA7RnmmKeZYWS3dS4EOb0KunQa+6Mcd7CKJDQxigAcEdtcs6
        8X9PPKjFZJObADSybq2f/KZRlx4Z0J2IAh3rf5U=
X-Google-Smtp-Source: AGHT+IH82U+qQW1/fjfJ/os1LVT3gIIE5vs0bOUSx++/LWdM/7KBiDlOhMuk93+4g0UzB23Kgw+lvuTgeakfv2KzX/s=
X-Received: by 2002:a17:90a:744b:b0:26b:5fad:e71c with SMTP id
 o11-20020a17090a744b00b0026b5fade71cmr8950587pjk.2.1692712778783; Tue, 22 Aug
 2023 06:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5ByXdEK6Zsa3ObNinnROn=qsde_xvn3WcR2RLioMKk0JQ@mail.gmail.com>
 <CAOMZO5AR5AP_bBJxn8GE6sZXQq6wgzU-qDda43567fs=m7eoRA@mail.gmail.com> <ffa78419-4944-b777-3ff5-58651363a17d@linaro.org>
In-Reply-To: <ffa78419-4944-b777-3ff5-58651363a17d@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Aug 2023 10:59:26 -0300
Message-ID: <CAOMZO5A_V7XK=5ap_AtFnEwC1VOVkOpP55wSQQmGox6B2PCJog@mail.gmail.com>
Subject: Re: imx8mm: Forcing a reboot when critical temp is reached
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Tue, Aug 22, 2023 at 6:40=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Yes, you can override the function by defining your own critical ops in
> the thermal zone device ops like [1]. If the critical ops is not
> defined, then it defaults to thermal_zone_device_critical().

Excellent, that's exactly what I was looking for.

Thanks!
