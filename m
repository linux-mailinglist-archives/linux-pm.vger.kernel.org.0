Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4BC254B3E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgH0Qza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Qza (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 12:55:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E36FC061264;
        Thu, 27 Aug 2020 09:55:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z195so5191160oia.6;
        Thu, 27 Aug 2020 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=v483s8xrYSzjz1MKg/llYnen68ml62j7JXePfBOF9rc=;
        b=inMF9EfPRyYR2v4n6gY75VgLNyLRETpRc3y8AyJgW5+38mlskrltryQHFET/r/RfM0
         cIeD24Seaz0xI8pgPVUEsfPJ9RPDrfGcySpko5K4T6BjuUXpmawoMcRc33/kgwHY0oq1
         4kZ0FvNRPebKH528um81q98eDrnGBvD8Q7c7UMByKn79jYh+ZJpnmNFItSzsHFRhJ6Tb
         fkdcjhSOVSr9a2AGRlQvs0qXQiOYxZyWWrW+pMuJXKxf0cLc1nPWvPHl1mtmCsNxlNmq
         87db7/xfxEe6MSFAStZMd1nIdwX21pkwOVU1e7XiDlGzW84h7tq7dmQRuXnkExuKhUyo
         /g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=v483s8xrYSzjz1MKg/llYnen68ml62j7JXePfBOF9rc=;
        b=tqTOln8LjaesL7zsybr9PkN/0CEK/3Ut8Vk6Hz/ynFRvR4WSEBf0TrpOZOeZZw6T2c
         a87dWh/HWjbJd4+xI33t3D9TNIHm3o5rugFUwFGRvqbQxMEQFgg7lyNtbBSU5g6j0bWy
         25yNeazvkGClDPm3PnLf3oEBEK29YkVTBDQPpSQp9Jn1TX2DI1YAwRo0BgHsC4LU6X0i
         +ZXRT6e0UGdvnBkZfGHKFZ7BUiaU9yXLhKRfud+TYwqbXtywPyCYEkM8paKQPjhylRqG
         zBxwbYNqRUqqwhsdTxGO8vezVbdp8GI6HhCcnlRsZHdJz6cIBysfoXJQjSZVBhWrewLG
         NOrA==
X-Gm-Message-State: AOAM530kVjX1D7LjAG5bh8UrLau1TsTZFcO2eMJiUPb0WMZq1PqTh5sU
        /z7e0iA7x1e0qK4HzQaF2K4U+STSOg8FH4WrbutIBSKkc5XuWw==
X-Google-Smtp-Source: ABdhPJzBb4znbCq+tSfuo+l/bexoPkojJHO8z/p18PIp9VlwwPQliWukGo/wol5DzaPS0vkOe7ULIOaGrRB44dSrX+c=
X-Received: by 2002:aca:3a84:: with SMTP id h126mr7565692oia.125.1598547327976;
 Thu, 27 Aug 2020 09:55:27 -0700 (PDT)
MIME-Version: 1.0
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Thu, 27 Aug 2020 22:25:16 +0530
Message-ID: <CAPY=qRRekJonX_iX3s4bfietm9D_GM+S4cDGXbj9nMOefJBdTw@mail.gmail.com>
Subject: cpu-freq: running the perf increases the data rate?
To:     linux-pm@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

 [ Please keep me in CC as I'm not subscribed to the list]

Hi all,

I have an application which finds the data rate over the PCIe
interface. I=E2=80=99m getting the lesser data rate in one of my Linux X86
systems.
When I change the scaling_governor from "powersave" to "performance"
mode for each CPU, then there is slight improvement in the PCIe data
rate.
Parallely I started profiling the workload with perf. Whenever I start
running the profile command =E2=80=9Cperf stat -a -d -p <PID>=E2=80=9D surp=
risingly
the application resulted in excellent data rate over PCIe, but when I
kill the perf command again PCIe data rate drops. I am really confused
about this behavior.Any clues from this behaviour?


Also I noticed my system not having the 'cpuinfo_cur_freq' sys file.
Is that okay?
cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: No such
file or directory


--=20
Thanks,
