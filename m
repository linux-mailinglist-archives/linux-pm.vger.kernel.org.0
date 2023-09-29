Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16FD7B3A32
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjI2Sp1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 14:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjI2Sp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 14:45:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB21AB
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 11:45:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-69101022969so13013883b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013124; x=1696617924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYvvehpsv1wV0TUOJ3vJBMvoWOTY9QRuZLtItNWRlh4=;
        b=Zyitjam0qO5uRgJ6uhXe/DeqenrEDsPN+B9GJtq8Xa9uwn85g5QeJxGrjLYb1V2Ui2
         i3icp/ioq2tm8FAev2/RcCReEc+O3RDAUFNi5ci+C9RyfwvTavw6zGWOHXZr3zSyURpU
         8n2pDX5LvQD4x9MCc7ax7a2Ncldz+drrR2B3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013124; x=1696617924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYvvehpsv1wV0TUOJ3vJBMvoWOTY9QRuZLtItNWRlh4=;
        b=cLhlp7U7rXnb2DhyFSujnXtH3iUagOrJAwrCRLFDHQNF858CPKPRjzaYvs3hwHOLfO
         ps1ipNO0/IW0QjVO4VtRSqZixFoY+gqX4QXLfKtNggLr2yOsuInZ88CYtP64ROqEWCqe
         Q6+7nO6tfBfKRjbp9fwGg0GrhYKniU3DMm7HplBFDm7+v/eOLLzZ0B/LCySikrINtHKp
         tsJEd0vIoHtlKqiq+bTHAJ8RKdddkaeKvQu681XIoW4DBpJeYErbRKj5pTpA795s9EFh
         V45SY+0DywVi0/CwY5HmCk+J8ZnlVmS88QIr6Mcg4CE8KclBQncS9LY52Jq1xcayW226
         tC8Q==
X-Gm-Message-State: AOJu0Yy0Q2FfF7vBio3n1dlsuzlSWGvSxftjr9fz+EVykNMKdwklbxd9
        lfOdFcldYuhDtd3MUdNfPvcA/Q==
X-Google-Smtp-Source: AGHT+IGFXw3HGbe7BuDnIOEXbQlJ3E2VZIJO6eZbA0D0+j0Hvk6pixrOymO/vfTRQDQmvRsKnAaxFQ==
X-Received: by 2002:a05:6a20:1604:b0:15e:e0fd:98e7 with SMTP id l4-20020a056a20160400b0015ee0fd98e7mr5722710pzj.20.1696013124059;
        Fri, 29 Sep 2023 11:45:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7848d000000b00690d4464b95sm4795297pfn.16.2023.09.29.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:45:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cpuidle: dt: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:45:22 -0700
Message-Id: <169601312172.3009670.14336910026222113184.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913-strncpy-drivers-cpuidle-dt_idle_states-c-v1-1-d16a0dbe5658@google.com>
References: <20230913-strncpy-drivers-cpuidle-dt_idle_states-c-v1-1-d16a0dbe5658@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 Sep 2023 00:23:19 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer. With this, we can also drop
> the now unnecessary `CPUIDLE_(NAME|DESC)_LEN - 1` pieces.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] cpuidle: dt: refactor deprecated strncpy
      https://git.kernel.org/kees/c/fd94c38f8441

Take care,

-- 
Kees Cook

