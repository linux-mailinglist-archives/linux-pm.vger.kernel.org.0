Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACA217DA84
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgCIITG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 04:19:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53950 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIITG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 04:19:06 -0400
Received: by mail-pj1-f67.google.com with SMTP id l36so1266199pjb.3;
        Mon, 09 Mar 2020 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b126q4DqzibX5cGWOXgCwm/SUajAvk8qLJv/aL83Yfs=;
        b=SNJxfUQMAQG/oj6VF2coTyVvOIYt3XMxjPNZoE6A1nqPtuHafSAEfBSLPY1oWdIr30
         kaMrSGKPmMsDx9oo7FkotMCdI+FDdjFhR47OW3kkJOqsM8sXVLK/+lMpyNzEARxs39qP
         8J7QOnT18MAkXEBVkoMCmTpIaScatrQyCYWY5LdtdzzHxp4ZsELMqs8BCBsCD78Duiqf
         Q+JL8Q0vXnKMeoP2/YG+7+pqUur8yhaowYhL4NsYqOa5HHTZg59+tvhouWkFsgZCQLYv
         SLbJnOjJCat+ZP503+Mq4mlCSbZfs2oTL7KwaBQdte5wtTPfe8DfpFjB7zAX324Ey7kK
         aSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b126q4DqzibX5cGWOXgCwm/SUajAvk8qLJv/aL83Yfs=;
        b=W2u6KTgewM537xFJZH0c/HgP2MBeFPd/keTqFAj2n5NwdXc9lrilcVns+qs4NT8p1a
         BSU32i1uPP0K+trzUnkocbN3liUqsurvRgyLufGZyW0S/CifpGOdtbau2+IZC0p9GdEJ
         pdsvx8Q3qwNJ9FYYH3UprPMWqbE85dOZewb/XswpbxgEHgO8lk61gGhMKMp7oDnoT9HP
         fcVGVNAHVgC5nGgvzXXgrBv0z+i3RmRiyNzRbvZ+ZJrhXNhoSP5KPEpGvV8NWQpfjFJO
         GtiHlUZ+so3bJu82doQMNoEkKZJF3OCUh2ZW7ZZlNhqW6pd6sAC+ulSOQQ6Ikpc6Ptz/
         uQrg==
X-Gm-Message-State: ANhLgQ1yjm2MwbJgN1aHeUItvpvrs8ne3AC6cmKAIY8lKavXNKbZjeQV
        Jo5cjAEj2geDk+kah3zQ7vQ=
X-Google-Smtp-Source: ADFU+vsQF42VtkDq+fAiy5iVu3dSX6rOcDKzrJPohcZmG01oVBYOzA+drDZYYNaYFbnkYuDuECKuhA==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr14900060plo.156.1583741945481;
        Mon, 09 Mar 2020 01:19:05 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 193sm21862277pfu.181.2020.03.09.01.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 01:19:05 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Some optimization for SC27XX poweroff driver
Date:   Mon,  9 Mar 2020 16:18:43 +0800
Message-Id: <cover.1583740881.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch set fixes external subsystems' power issue and allows
the SC27XX poweroff driver building into a module.

Baolin Wang (2):
  power: reset: sc27xx: Change to use cpu_down()
  power: reset: sc27xx: Allow the SC27XX poweroff driver building into a
    module

Sherry Zong (1):
  power: reset: sc27xx: Power off the external subsystems' connection

 drivers/power/reset/Kconfig           |  2 +-
 drivers/power/reset/sc27xx-poweroff.c | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.9.1

