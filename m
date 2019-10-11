Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D4D47B2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfJKSgM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 14:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbfJKSgM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 14:36:12 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2618B21D71;
        Fri, 11 Oct 2019 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570818971;
        bh=F0i5LImbPdwjKpMcjmA3DQC81Y38eji4C5T7CPPrp9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mCZbRKIe425xYovveqmcmKyiTIqN18mCSZTPJZETib/w2adHOPdoPbKs5P29wVewb
         LeJ3JbCNgIhirIlP4hEOBpsaW7PX2+oypz0kNsqV4OpqVQd6sagxBlRcBQWmjrlyl/
         uuOqYFNbUnXMxfrxp6mFtNSGU0Mxj7hystNB2hTE=
Received: by mail-qk1-f182.google.com with SMTP id p10so9774108qkg.8;
        Fri, 11 Oct 2019 11:36:11 -0700 (PDT)
X-Gm-Message-State: APjAAAU28GGG+xqiJA31uVhHGIz+eFP0jdipaM3kb9KjCXV0YvTDhGhY
        J5VSI+MxlCLyxHZXynNOXW1s13sBPTiXPaeoBQ==
X-Google-Smtp-Source: APXvYqxMfo6sVYSlq8G32z26ni82A0D4JhoieTjEs0ZK/Y/KBIZd4wZ4PlAcMe6QhlpPLn6YsXah1p9yBvfHROhUg0k=
X-Received: by 2002:a37:98c1:: with SMTP id a184mr15988314qke.119.1570818970225;
 Fri, 11 Oct 2019 11:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191002152125.16227-1-benjamin.gaignard@st.com>
In-Reply-To: <20191002152125.16227-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Oct 2019 13:35:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKWrJjaoHWBrEJuA0qQ2tOzNuzGO6OCtH_Ccmfw89K8QQ@mail.gmail.com>
Message-ID: <CAL_JsqKWrJjaoHWBrEJuA0qQ2tOzNuzGO6OCtH_Ccmfw89K8QQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Convert stm32 thermal bindings to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 2, 2019 at 10:21 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert the STM32 thermal binding to DT schema format using json-schema
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/thermal/st,stm32-thermal.yaml         | 74 ++++++++++++++++++++++
>  .../devicetree/bindings/thermal/stm32-thermal.txt  | 61 ------------------
>  2 files changed, 74 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/stm32-thermal.txt

Same comments on other conversions apply here.
