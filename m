Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FAC7B3A30
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 20:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjI2Sol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 14:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2Sok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 14:44:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC87199
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 11:44:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2774874c3daso8239103a91.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2023 11:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013078; x=1696617878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aC3vmtsMplEH+RxAjyp3uzmOqoOqrVPhV6qAz/nGJcs=;
        b=jNPF+pmfpOrk7dDWm+R7ca8CI5cmfU35+RwiIvt9sFgcFqIZXf4kh5OEbfWogEW6Sa
         +NpEsPmDcsujg8qmSyPaDmX7idxklTMLlvOy4pR2NzX35h76wJNhoNSYIiZPG/0k++2d
         P8Tecf7+XIOG9PKCvXhCVmO6io384UCApJjEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013078; x=1696617878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC3vmtsMplEH+RxAjyp3uzmOqoOqrVPhV6qAz/nGJcs=;
        b=nP/lRRXOCh/NgHH2EfeXI3BTIY4GK3Hoo0I70wL7UKAPH6LI46VfpvE+Qc2gPkAFMd
         74f5oJta0d9uNgGWGKtfEegp9wXDgGprY0s8JrvxQ/jA7y7yUrMQMjNPgdaF+bHHCl3y
         +Ix/hmQJzD3758h0tX2o0cLdL2DGymPfENVE0C7OUHzainBhTc9OeVkPOPW1LKX7JCpG
         XMvXW7BGcH4cUkWF/LAkcWJegw3bytnHfIiJmB7tx1YK6Abw+HqkGk5wYc+I9wsWgcBs
         h3pX9bktbFV8N/TdFJXlbBw7uS15HqiiCT1XPLDi/O/PtLi8W4syU+P8jrwQ/I6O9Iky
         55JA==
X-Gm-Message-State: AOJu0YxxiZf3kGIRT4KuhmWTdz2iJu2lrmCvjJhldLUxUy6MQJe9695J
        HPuybwkYN8XSRlWsE3JPynwZRA==
X-Google-Smtp-Source: AGHT+IHRMZLuA39bsh6lkUIk2/rJe4jxa8oXQY30qNHdfofUpXO9vWlfQ+5KPg1feOEKBWERqMeObw==
X-Received: by 2002:a17:90a:4f0d:b0:268:ca76:64a with SMTP id p13-20020a17090a4f0d00b00268ca76064amr4370278pjh.49.1696013078334;
        Fri, 29 Sep 2023 11:44:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a198f00b002776350b50dsm1954643pji.29.2023.09.29.11.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:44:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cpufreq: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:44:36 -0700
Message-Id: <169601307508.3009351.8138166691228989474.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913-strncpy-drivers-cpufreq-cpufreq-c-v1-1-f1608bfeff63@google.com>
References: <20230913-strncpy-drivers-cpufreq-cpufreq-c-v1-1-f1608bfeff63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 Sep 2023 00:07:21 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> Both `policy->last_governor` and `default_governor` are expected to be
> NUL-terminated which is shown by their heavy usage with other string
> apis like `strcmp`.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] cpufreq: refactor deprecated strncpy
      https://git.kernel.org/kees/c/598b1b1c8f35

Take care,

-- 
Kees Cook

