Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845AB1F21CB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 00:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFHWXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 18:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgFHWXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 18:23:36 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3BC08C5C3
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 15:23:35 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g3so18384714ilq.10
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IOyE3fBHvQo+Zh3CkzprspTxqYRTQ3yhT6gGhhPfw24=;
        b=Fkp+65jhAAgZa79YFMGfjElTF9GgmQcCScA2uqf0Ea6WUTRgOtscQZjGHo9fd4wmpi
         Wi+XgtegOPCLMu4T4NJX8TS3Ls38Po3hPSvtU0wtkN9UEM+89lMjAqEPVjDdU96S42Rb
         Q5JUczLAHWtvX/KddbxK2X7/opnC8sAwNAXLHF4ragapUS9oHytChcBrM6PRvDVY324f
         f7TAGf684QnrHiCZUDV1reAJ6XXM9B5vEAz0B6hvUe6RLSHG+vM2JZrTXca7vuuI9NVz
         1hriAp3TTaViEg3nX1q9mXlkdij6mn6XtvZ/ftTlFCh12ODjYr5yn0NGdOvzM7K8dYps
         xwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IOyE3fBHvQo+Zh3CkzprspTxqYRTQ3yhT6gGhhPfw24=;
        b=rgqL87E06+svg2mGiiaUoWeBVLuq4AHwlL7SqP8C9/m3tr+wrchA+c2rOZDsG+RHGC
         O3ojPc8eiPMefcD78IDmEvdVRZDvZ1mmsACAOOpIax/baSA2LWBG1ljwqdx7hIOLU5nP
         mJizz5wftdASHdvFbqRlwkclIdnKJfrmDiF7+rv4l3YNovejXyhLxvPBBtvez86VwNtE
         Ax6qGKeEcPM1BLgtxRcAXMK2BonfNwmGP4fbAQ/CvWmcyd+iu4bng68CvUanfPqMGvDd
         6tpwYbOnncNyD/ANilgyajaYby5BAUclUDSd460lr6VM2//8c0wrN7smXuF0VoiNfKOU
         QvpA==
X-Gm-Message-State: AOAM5335lNXSEvxq3axBOR67bYRQaCua2Hjhdnwws/0LbXUuBNmmNx1F
        A2HM5gscFis6IFNBi9mThdK9/xcOD/F2IDklLSCKEQ==
X-Google-Smtp-Source: ABdhPJzsZ9TDVgDy3gIz3iyJ4NkEHSDSi7Yj5G4NoSs+wvihQTtx2FHPNlKzSR0PDqTRe+hISmuO9fUvRw7w4Ihe2cQ=
X-Received: by 2002:a92:cd11:: with SMTP id z17mr23379483iln.55.1591655014745;
 Mon, 08 Jun 2020 15:23:34 -0700 (PDT)
MIME-Version: 1.0
From:   Luigi Semenzato <semenzato@google.com>
Date:   Mon, 8 Jun 2020 15:23:22 -0700
Message-ID: <CAA25o9QUtut3+nEs0H8H5qa2H7tQokq+_UoOrAaVGhmYvMTz0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] PM: hibernate: introduce opportunistic memory reclaim
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andrea,

1. This mechanism is quite general.  It is possible that, although
hibernation may be an important use, there will be other uses for it.
I suggest leaving the hibernation example and performance analysis,
but not mentioning PM or hibernation in the patch subject.

2. It may be useful to have run_show() return the number of pages
reclaimed in the last attempt.  (I had suggested something similar in
https://lore.kernel.org/linux-mm/CAA25o9SxajRaa+ZyhvTYdaKdXokcrNYXgEUimax4sUJGCmRYLA@mail.gmail.com/).

3. It is not clear how much mm_reclaim/release is going to help.  If
the preloading of the swapped-out pages uses some kind of LIFO order,
and can batch multiple pages, then it might help.  Otherwise demand
paging is likely to be more effective.  If the preloading does indeed
help, it may be useful to explain why in the commit message.

Thanks!
