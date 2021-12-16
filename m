Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404D14766D2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Dec 2021 01:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhLPACj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Dec 2021 19:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhLPACj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Dec 2021 19:02:39 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B0C061574
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 16:02:38 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h16so20749377ila.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 16:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=6XyN4LSJGdGrTBJKy5tOX8mtKoTcrbLChwGCkvQWWNM=;
        b=S4Lu0PS4JTx0Y2qd3DqHRwjHehczgeaWh8PSxqF8OpgQZ04k06TPtllL2zBzC/8Ekj
         AoqqA0K2rBUK1qCl4yZ4DMrEdwzM7qaUjfsNwuyOpmASFmn3ZL2P0z7czM2C8bezvTZ7
         KSDIyWeDWxuvhsbK1yMjlcs81DokVxWRAtffVr2/DHC4llF6rNTaiX6Qo9nnOyIuMucT
         65cjMge2SYGrhiGNTlH1F55dWTZLDTGT9zPlaM2WEfojbzniz0stNPfSTyvF/UM5hV/w
         qKrggAq96hSiePuv+oMmYmuA2wcGoHz4NQ88xATQcXEB7LXH12n+oGAuvXJVxXFSbd7U
         BHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6XyN4LSJGdGrTBJKy5tOX8mtKoTcrbLChwGCkvQWWNM=;
        b=KiZ3zUkDMg/u6q7/3qj7/8qYFGxZxhAU/CDtiMcPyKOu4r+/rnS42YKd+261CZgIpl
         ZJZgdlsTnlatopCmHmRYmQxjvpIP8fxxjQj/G5UXyI47KDL6Th0eZXiq9RSAlW+sGjUx
         UQOgqZIfYa4XJ1aCe+Iji1nQdb32JUghho8RQ4GQDzVJ2VMJ/SRlssNelNuss9xcREoo
         e7JAi7CufAeby8V5egkR+KNhS6tkOcpioUL81KNGDKhI4Ki0OEpzQBfobKGaFZjKSAYP
         rSm7mxXUS9yc/77ufGMAJFpz6ppLa1KO/iokgHpNr4Q228eIkXzVXe0AHY5Naqsqyezj
         U/Vg==
X-Gm-Message-State: AOAM530mL+wMnwhKLFHTn6nLx8MOrXBoNRi4oNdlFlQANe/onaHBNr1h
        WkCAMSyPEpVkWVSLs2G1yRvhFW+y4HNzUf/PFap60L+s3KQbJg==
X-Google-Smtp-Source: ABdhPJy/1/n0Ce5qiVzgyS3OLg7Csd66w0vaVLhPPnYvJS/JkAiwEmPkczYE/Zv+DurDHmC1MtUaom06KDgl4qx7vMA=
X-Received: by 2002:a05:6e02:20c9:: with SMTP id 9mr7789942ilq.245.1639612958318;
 Wed, 15 Dec 2021 16:02:38 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 16 Dec 2021 01:02:02 +0100
Message-ID: <CA+icZUWoKBL9DYY8dcNMvKMV-UgfdEsPrvwzueE85N6PqMOK1A@mail.gmail.com>
Subject: [Linux-v5.16] power-supply git-pull request?
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

was there a recent pull-request for your linux-power-supply.git#fixes
Git branch?

Restarting my activities in the ClangBuiltLinux project I am
interested in Nathan's "power: reset: ltc2952: Fix use of floating
point literals" patch.

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=fixes&id=644106cdb89844be2496b21175b7c0c2e0fab381
