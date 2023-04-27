Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5556F064F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Apr 2023 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbjD0NEy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Apr 2023 09:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbjD0NEy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2023 09:04:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA030C5
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 06:04:53 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b99e0ffbabbso5991569276.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Apr 2023 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682600692; x=1685192692;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9OtUw5qfuvq5waaIwQtysg67SaToj9SLYSO+4dneqU=;
        b=L5wpu/BuUroCNQV4C1VSRaFoCvTuRrtLUHYof/hcujgvKWjNOXqiccK7WMlgEzFkxs
         DJPv6f8rRpR8FYCR9jW8KCJaGnXqTvcRptpXruV5n1p4eZ8xeVRK0XWsuYnsf3D3L0du
         GGPmCtR4FmaAjFVuEg91QVTp/vpXfW9oJVVxG2FD2/9m3l2fmFR+tfA27vfjiXEidsUN
         QfjS37+p1UZDYEGw38Uh7A1OPVzEY+csbImGowk1mmg3d7IXtyewGzOqIuwNpzbDggYR
         Gev6qesLIgvsb1M0O8TxdDdXenxWDTU66TYbSttZ/brSylyywIFIkJFA1EYsnRN0F5y4
         /0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682600692; x=1685192692;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9OtUw5qfuvq5waaIwQtysg67SaToj9SLYSO+4dneqU=;
        b=kKhUcSSGSIbBKHildK/b8CmlHD131nhfivZLoDlAIqKOrb12XbhcV7E6jl8IW25b05
         0UPqs5QkxvwwdJI6ghzuTdmxjujqHeTmHD3dYEtsdVEqrdbldtMJnp1eMKETP9LyE0iN
         n7wMZwXGFxb79NI/vBtxfVsWBB4OsZUd2NaU9DkATp50Bv4IUrE4xTdyTYdWFIBeAj66
         6Hq+FFNyCpHb2qip0fEDaCPUID7pNlvVi0T0Zl8OW/Rq0Q0I9Wfg+Aq0aDc4ubCCiT1n
         76fnuejZm2SNTnwfQ4RYugLdYCG7rMlqaLBdL+aBLjeBwPFvpIRV0lgXioghlU3LTyXK
         s9Wg==
X-Gm-Message-State: AC+VfDwipS5Pcs96IVlOft8dYsRnrTBJtyHGco0FFk0y79ep9//s3bvs
        jVZ7Dhek1ziw3m1wUa8hczl+UxhrR8M/k3Gx+RA=
X-Google-Smtp-Source: ACHHUZ5DQL8F6m07PXfZcEq52NdSMjX4QXj80+DOLwR2NJsUFwg50kTZsrlMP8oUNOOfC8Xta22dnSZWSCUm/C+IV3E=
X-Received: by 2002:a81:a1d6:0:b0:556:2699:f3c9 with SMTP id
 y205-20020a81a1d6000000b005562699f3c9mr1083042ywg.27.1682600692562; Thu, 27
 Apr 2023 06:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4393:b0:34b:d28b:fa30 with HTTP; Thu, 27 Apr 2023
 06:04:52 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <fatimamuhammad5689@gmail.com>
Date:   Thu, 27 Apr 2023 13:04:52 +0000
Message-ID: <CA+QAR6UwXa3M2NFdN3Ji=CmDT-qEtPjhzMX52w=MrRvons1J_g@mail.gmail.com>
Subject: MORE INFO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello best friend. i kindly wanted to know if you're capable for investment
project in
your country. i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email.

Thanks and awaiting for your quick response,

Wormer,
