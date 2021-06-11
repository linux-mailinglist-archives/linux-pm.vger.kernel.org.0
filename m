Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51A33A3FFF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 12:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFKKSn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 06:18:43 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41856 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKKSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 06:18:42 -0400
Received: by mail-lf1-f41.google.com with SMTP id j20so7768255lfe.8
        for <linux-pm@vger.kernel.org>; Fri, 11 Jun 2021 03:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHSHhv8DH5N4EUCGo4h1bBiaEnjkumBewOX9z/LMwSQ=;
        b=QA4jVvVN4LCK88DiOg8DHx/xUKJiUsKHH/u21a9FmFHZL+Mu4uDVyUK9ki3+EcaVxz
         l8i74R7wCybyiqMTz0t99+VmhIk78TEVsDZAO6Y0Tg7ZtZVKpxYHkymUtDp4azG7fk02
         e7JFw3FLOa1RNG6Ss4gobTt1yM3BVT8z3tv1VxOx/vw3h71hR1fcYjxY/qopX2Th8qX4
         R7p2gDkyCBj2FaHhT07M7s2WQyPi/M5PQP+mWTfAzUr3TCBLnh/t7XzHRShCnSldQHIf
         kEH5i1W5hA4dO5K+7MW53czeYfRE05QCQmqnwp653Ehpywb6BVwIV37Zj44BoXx4bwEC
         fruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHSHhv8DH5N4EUCGo4h1bBiaEnjkumBewOX9z/LMwSQ=;
        b=LxG3PIQ6Ao512OyDui9tVKvKdzIzEyMrV8lhhbWiVZDQt8AOiNZz2DA11s61qSljUA
         +JoPjJD70COZJGqXViIdXBSWVcSloRMOilCYy6cmqzAtlNeWM8EPhpsQsgLvm1LB9JIq
         ILVikDowmjs5SXE57Kzq+xBQ1ZL8dwF9XXalLzE5ES5l0l4g9J1VHZneNl74ET6R1uvk
         o3Yp+t+0dtXTxW/Td6YeXy5Dc+ICCG7jtJbwoiWmU2P6xvxkGD3uclX+kVWDPoOTEwyl
         Os5ArJo1RJL7uaXsvp2X2jCHwhGu+7rb0ArRZqi1AKuM979ThswCsndNQ7bzxIxcT8k6
         BEvg==
X-Gm-Message-State: AOAM531YfR7b+1NEcvqk0se1IGNYrp0nfcVZS9QYR+nDfRps2RXsqjEQ
        bLDsfR5WObXBfKqyMhS1J/zu0A==
X-Google-Smtp-Source: ABdhPJxBZ9vK96gsXAjYydEfz9jpbzWYekseICjHgXuXnxlGOrppnbIcfyEiu+1iDIBmJWbn3ZVHbg==
X-Received: by 2002:ac2:58e8:: with SMTP id v8mr2231704lfo.35.1623406544295;
        Fri, 11 Jun 2021 03:15:44 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b28sm552097lfp.197.2021.06.11.03.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 03:15:43 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PM: domains: use separate lockdep class for each genpd
Date:   Fri, 11 Jun 2021 13:15:38 +0300
Message-Id: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is not possible to always use mutex nesting when locking/unlocking
genpds. See for example the trace in the patch#2, where genpd calls are
broken with regulator calls (genpd enables regulator, regulator uses
another genpd). This causes lockdep to print a false warning and stop
reporting further warnings. Break this by introducing per-domain lock
classes and use them to clearly track genpd locking sequences.


