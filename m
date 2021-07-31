Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6842A3DC573
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhGaJgM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 05:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhGaJgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 05:36:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A9FC06175F
        for <linux-pm@vger.kernel.org>; Sat, 31 Jul 2021 02:36:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h14so14530038wrx.10
        for <linux-pm@vger.kernel.org>; Sat, 31 Jul 2021 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5C+aadWlGm3pyDZHnIxcqI4yWkk2H1rJm1N6zZe3Vgw=;
        b=hNJO0pwD4ytpqA1aNrJ9Neh7XX1Hio8ef2T4F5UldbXJNbSEu9jqAEtzugo8jMHoVP
         ASj08YHYf+PQSQ4xUsHYL28EjhM3A9kHOKHIr7PLxiQ0/Reb0U1RrrS4UjaDsxKAYzFE
         /efVj/S+oO5Wd12P2geQMdrHrhXX0spi/cgKe+CQs/1OLLx89Ji+ZNcAkHpKas5+UIpn
         2giTJpkg4uW3u15WsulzSD9hk/XmHBF4fDsW6CQFay1MD+71K3pxtuzjJuOnLoVT3gbg
         oHoiNp6FfJgnS8Gt25kG70kva6znFvgjMowuQXAw9/cR0S1Ea/ExI9SoGm6T7i30ZYl4
         IYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5C+aadWlGm3pyDZHnIxcqI4yWkk2H1rJm1N6zZe3Vgw=;
        b=OZpQ3La5bFJ8VKWZqOh4tlPZ+KRqs92qV8cbLfplC4t+4APa0YgMWS2/bu143PsOPs
         E7AeGOsGLaTwdlNZ3R8CAQPoNDx2y1RawUavPW+OIWKpT1D14tF+npORlhb3LbjZpTaD
         Hf6OxigLUUS8O1d16/kdUY5fROBeyrSJgY8TYlE5XghZyHUycWwP3L/A/uORo70HQKrR
         /3l3T9f2P3Llt7QHt6EwdUSZZTB4NhPmzLWsoRE4r+XhXhhBJu0M6rQSDIZbpiP7ZQBR
         8r0eeiy2OaUPWzhpOpB+RItdzPvOb+ZLopDViGlMTwWkJGrsm5+wHfa58DiHMvKDGmRB
         Lf/g==
X-Gm-Message-State: AOAM533IBk2MyFSYZfZFe27y1PVnE0O9xC+5P7QrvGkcPibM/gJG/B+v
        fs8S9T+r5bMddNdvI/W48xvCVXRLqbw=
X-Google-Smtp-Source: ABdhPJzFwVFcooO0NwC+zgvoDPPfBmoHMvBbRczE54Bj/ZSNTQo8RhAsj1q0zbk0ln9sVJ5/FCoMZQ==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr7277876wrs.367.1627724163327;
        Sat, 31 Jul 2021 02:36:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3a:f500:f1df:24d3:e1a5:168a? (p200300ea8f3af500f1df24d3e1a5168a.dip0.t-ipconnect.de. [2003:ea:8f3a:f500:f1df:24d3:e1a5:168a])
        by smtp.googlemail.com with ESMTPSA id p5sm5139656wrd.25.2021.07.31.02.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 02:36:02 -0700 (PDT)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Annotate pm_runtime_resume_and_get() as __must_check ?
Message-ID: <0edfdadc-336b-657d-5566-beeb4f4343ac@gmail.com>
Date:   Sat, 31 Jul 2021 11:08:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Seeing an erroneous use of pm_runtime_resume_and_get() in a patch I wonder
whether we should annotate this function as __must_check. If the caller
doesn't check the return code he doesn't know whether usage counter was
bumped or not. Therefore I see a good chance that this results in a usage
counter imbalance.
