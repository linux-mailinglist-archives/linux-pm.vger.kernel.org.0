Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992DF69A8F5
	for <lists+linux-pm@lfdr.de>; Fri, 17 Feb 2023 11:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBQKRT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Feb 2023 05:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBQKRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2023 05:17:18 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051C9753
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 02:17:17 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 79so365241iou.12
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 02:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2XHISwwrYptru9JJUybZluXGFlVbeF2fOe6BiDI/QUI=;
        b=mBGopXLmCuUvn5ywjYARHgIrH3Vs5/8fi24S7z+YJ1cq2a6mg8K/L7HJfJ14mWtyU9
         NzjMsu+kEPqqScnha+85Ip75tCHt7ZE5mP13HSUTDJAjA88AakPrcrmtQgPOUROkDVHu
         ThMzH163B6nkvUtbZuKhIX7sO2y/WwCcKEsVCaJEpjjnMpwMj2qhpG0EoXDT27bDIsNM
         7ueHkUKdi9oeyDU/XrNDXcKtWe2sQE67A6azORB8XnXaKR2Wq2qUUpV/l8EcTDo4qhNK
         GT8dMB6ExDAwZwJCyvDvDy3ojOlfWjiM2mj9SdP1uuv/7CUl9rwhWVoKfflch+6w3DpD
         kZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XHISwwrYptru9JJUybZluXGFlVbeF2fOe6BiDI/QUI=;
        b=AN1UKN8ie3GaZ7VqneP48ih31Uif7OdFklKAmIDaGNfQ8POQzeYF08rdyI7eObxIED
         lbcCvD+aT2G6QF3DPkOHapIp19e/0WRVvrJkHtkliqHd67XwIywoY7lkMfeKiSNO4AQ6
         NIdXTL+cNdP33OImveq3dP5bB6jS0HZy3347S9WI+9Qlu2zyiHYo1P2E95AweXoRKfHn
         VQO77QnL7U+OuWM6TR+6MDQ8s+DWQamoKLMPlqpGsSPEDkvYNMuXDYH3P8nLgUPLOyvm
         FboQVcJ1CNjrpR5TtzzQ6zBWX7HhgYc94urLbz1P9EFxuj5+Cc5y1xOLuDKbEyToyHk/
         xP+A==
X-Gm-Message-State: AO0yUKXWzx99oLxFhQZrOI+IMDKqvbRu0KgPaNwavptYjmj/y7W3/3aV
        TwcIs69N/S/RHa6MUrbcgTki8C2Qvc7eHggZ2bA=
X-Google-Smtp-Source: AK7set8N+EyZGFpnwa417080x+RlVPy0ciXkhyEs3bi7csMPOmuUEb0Mdppe5ikqtOFi2auDulsFVg1dAVANXeTkwM0=
X-Received: by 2002:a5e:9419:0:b0:730:1:27f3 with SMTP id q25-20020a5e9419000000b00730000127f3mr320741ioj.23.1676629037373;
 Fri, 17 Feb 2023 02:17:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:6f41:0:0:0:0:0 with HTTP; Fri, 17 Feb 2023 02:17:16
 -0800 (PST)
From:   Daniel Affum <danielaffum05@gmail.com>
Date:   Fri, 17 Feb 2023 02:17:16 -0800
Message-ID: <CAPkju_MDjmLNqCpyjyPP+dq6sEH8GHJityUM0_N1ZmVUiry_TQ@mail.gmail.com>
Subject: Confirm Receipt
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello

Good day, and how are you doing? kindly get back to me for update
concerning very important  issue in a business circle.

Thanks and remain blessed.
Daniel Affum.
Reply to: barrtonyduke01@gmail.com
