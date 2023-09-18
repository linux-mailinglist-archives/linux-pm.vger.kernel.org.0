Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098CB7A40C6
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbjIRF7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 01:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjIRF6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 01:58:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B4FEA
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 22:58:33 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59b5484fbe6so44305337b3.1
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695016712; x=1695621512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV1uCJ8pmpiIkKeLvWd+ZzcVlYy/aRUeYL380enELwQ=;
        b=eLDnyPWhaXgF1wtKykWq1r8CEEbAExVGwuf3VjxDhS8JkWEzg3RyQdt/jcT68uxI/h
         JUR9CZprDwZBy+eKplP5BXf8Q9r0m11k9VV6gZiSt47192IUvUc3QtZCocmZjJfcwb4x
         7w+6mxJ2529jx3pF1Dw76cv6BeFPWF+UumTwVXtz/PGuk7nFxITVB1K6KMqAUAS4cHYq
         ty+LT4iaMPXDOManj0VAK2dgJzsFuKJQWSJ8SK1PYz3faTivMRegvlTJm425TM2pKEa6
         mYtPSn/5bM/wqQhmdtctKnwvF9Xk0bLabbA3KbgneTdCq/iM/gmpAkc29KjMotoB9NYn
         trsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016712; x=1695621512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV1uCJ8pmpiIkKeLvWd+ZzcVlYy/aRUeYL380enELwQ=;
        b=Ec205nWALiGERj3f+BJfHSP/71RHnP8+GLKQPxPlfm1qA+UOgssfuFp2IEaJE9aUDU
         C7X9B0QCJ+jPm43MrJWc+h2D694oIbKXSw84mBArSN4ItshoP+J1bmdS2jHelgZ2l3iq
         U4IoWiI0Dh77t3gHSc+oJ2Yr18l3q62Elhqv2oKHjhA+LbfgDTy/wkVC9ZwTS/LKW7qE
         /YZZ8n8m+za5x1xAUNnp2K/eidMDWCwGtoIUZad3CZAhsZarDhBHDFXHQ8WgK4Ddpvou
         KzYfIUOx5jl7QBC4giRMcLvK55Elpv0wJUThhak46n7tLuhtZQOnGq/FCtCB7ENXKMF9
         8QcA==
X-Gm-Message-State: AOJu0YwLkDE1wf5aPuoj9T9oz0o0qz1K5b7Q9044QCYHzucpGVL50P0Y
        /FbUCc2t62CDuAgFYfTEflsaBZsDhrtxmNDXEZlhLV5BhCC+yzr7
X-Google-Smtp-Source: AGHT+IE2GGEGegrjeWO1lrgi7QNiOlH0eu34fYoq67Qp7gq81DXnLUWi/FDZIJ9TSRJzeWNHk2tiW0dzM3DiHHAoiys=
X-Received: by 2002:a81:79c3:0:b0:59e:afab:d5a5 with SMTP id
 u186-20020a8179c3000000b0059eafabd5a5mr864968ywc.23.1695016712528; Sun, 17
 Sep 2023 22:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
In-Reply-To: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Sep 2023 07:58:20 +0200
Message-ID: <CACRpkdZEo06hrYkcQiZe_3WP_vMahDP9vp6y2dGkYCroTtZB5w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: supply: Drop deprecated ab8500-battery
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 17, 2023 at 9:08=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Linus Walleij modified AB8500 to use the generic simple-battery
> and samsung,battery bindings. This is an unused leftover that
> can be removed.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

How could I miss this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
