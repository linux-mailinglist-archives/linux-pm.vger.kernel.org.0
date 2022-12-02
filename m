Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB263FFF2
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 06:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiLBFpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 00:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiLBFpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 00:45:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895FD2D8D
        for <linux-pm@vger.kernel.org>; Thu,  1 Dec 2022 21:45:12 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so4211564pjm.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2022 21:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+zEK6axvFIyAjhlFdh6KytUwkG1a72zTer3GTGMlwg=;
        b=IlOFxp/DA9IWiYacYPi9QR0masyco5aWsfZ6ELzqWtD77JbLAyiuDHyST/ZDkaPz3O
         tj0knQrXiOIjt4M6AIXbcY5cy561yVUXgtvnQitUuUHSIFWY/s074NFXLUmRwFmCB+AT
         yhK2Om1yArm526i6JD/CxefBV3QckGLFn8a5aNvQtLdhQwuytqx3C4rRBZMU4UMpLThg
         eYI9W3GKz1D+s4ajYvP9IOhVSJaM62JyrUutg6t3g/V44l+wmr6pW21WhEesfV5zeG/M
         P/4GqPAiiW/16WafMoVXWTooxgRj8BZhTUbuyVLapvCQVmZ/h2uuIkgU+b+v976oCRia
         GEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+zEK6axvFIyAjhlFdh6KytUwkG1a72zTer3GTGMlwg=;
        b=onZCOu7t93ma4z6RwilcashYvd29K795rB+s8Y99YAtkvRqWaSrkNHNEMO9QnY0jHM
         b+kikL4jIhmN1GMMMiB4GlN11NmRNWInLbntNI94kr4BUS9BYB02b4OZrINNc318sbBy
         /di0Dn7oOYWfog2gHa/H61S/ybgwtGKzUTVpe2rtDWiA8aUPuTyRfcSj2eraJ6LxGepu
         7VokctWXWTT9jkMxqe17ZP7E98tK+xTu7l2DDEPKyoXbJxB6BlzEUozfLUeXG+pPMQLA
         /P079UUuLSsDNxkn/wWlDdQiNkEgWjog+tXjMtkVCNaXzgiPx1ITVFH/GFfqvNQMQPT3
         qW+g==
X-Gm-Message-State: ANoB5pnr/eX8n8n7pVp1QZL9xmmAuVeHkEv1H8ktVjyKrpNje6k/3cnp
        EbKg8mS3eFUzGJCWYWc7bFVruA==
X-Google-Smtp-Source: AA0mqf5Vi/i22eoSUMrWqCNIOpm4wAFX63aC5wlgIv8b/MIhgZ82FoDehKuobcR+zLTZUstpJ1tJmQ==
X-Received: by 2002:a17:902:64d6:b0:189:8427:e5c1 with SMTP id y22-20020a17090264d600b001898427e5c1mr26177398pli.24.1669959912443;
        Thu, 01 Dec 2022 21:45:12 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b001888cadf8f6sm4608654pln.49.2022.12.01.21.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 21:45:11 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:15:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.2
Message-ID: <20221202054510.2dsvqjfxy7vaxfiu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit c7e31e36d8a262eb0bc2daf8f9b7481c83284386:

  dt-bindings: opp: Add missing (unevaluated|additional)Properties on child nodes (2022-08-24 11:34:22 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.2

for you to fetch changes up to dba79b78ecc18f7788fd08eb998388e226817fb5:

  dt-bindings: opp-v2: Fix clock-latency-ns prop in example (2022-11-08 09:50:44 +0530)

----------------------------------------------------------------
OPP updates for 6.2

- Several DT fixes and code reorganization around opp-microvolt-<named>
  DT property (Viresh Kumar).

- Allow any of opp-microvolt, opp-microamp, or opp-microwatt properties
  to be present without the others present (James Calligeros).

- Fix clock-latency-ns prop in DT example (Serge Semin).

----------------------------------------------------------------
James Calligeros (1):
      OPP: decouple dt properties in opp_parse_supplies()

Serge Semin (1):
      dt-bindings: opp-v2: Fix clock-latency-ns prop in example

Viresh Kumar (4):
      dt-bindings: opp: Fix usage of current in microwatt property
      dt-bindings: opp: Fix named microwatt property
      OPP: Parse named opp-microwatt property too
      OPP: Simplify opp_parse_supplies() by restructuring it

 Documentation/devicetree/bindings/opp/opp-v2-base.yaml |   6 ++--
 Documentation/devicetree/bindings/opp/opp-v2.yaml      |   2 +-
 drivers/opp/of.c                                       | 228 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------------------------
 3 files changed, 103 insertions(+), 133 deletions(-)

-- 
viresh
