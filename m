Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855CD14F0CD
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 17:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgAaQor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 11:44:47 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:41618 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAaQor (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 11:44:47 -0500
Received: by mail-io1-f49.google.com with SMTP id m25so8831542ioo.8
        for <linux-pm@vger.kernel.org>; Fri, 31 Jan 2020 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=boyCa+/mWyhSPeUShi1VxsaDV+y0pnBW25+L8k/IsfM=;
        b=BBVd6Gisp7BwnfgioXBclqiJ/yA31Nof0HCsgGy3TwoKglLFukeRqtnW4VVhf6wD8C
         yHK+QEpjb8wfwGR0IO82VJz/2FrQFElwIzgy6qjTeNr6zYWUuXkeuflmVTnrRktcJJ7H
         bwRAqGq4jhPpOU1p0KDxsdhG3RfTgSzXflSlZegFD0BGPCW16FXfVaxRXhvrlIuJiyIA
         ti+vb3Ja+7wti1honigoEpWbdQvCSVsm7h5DPoBThKmGWNL4sNnVy0G79AHMUWTbPcK8
         SNnjH/2arf/dcLsQYoIf1Q2kNTucCYQ/dYwZVf6+QWRsqU7QfTVGvouy/M8sVMwNqvpI
         Ayqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=boyCa+/mWyhSPeUShi1VxsaDV+y0pnBW25+L8k/IsfM=;
        b=XgqNRCOElOw4og58Ub2c12CcznxiVOP72pFBdZcnbso9DBXszo5s9ffAN8I7FjjmTf
         uNGGzzLXb9yvrN7yd7iQi4B4WVNdqagg8Zo8TPhMWieOiG1F5th/G9QdHBNTrlIaiIcu
         7v1s9u/WuRTTMNWnMLiaq4hVW9ZG9993OXkoHzATQyLgOuEtRdsuB4Js6ijjLoaLpPnZ
         GJYJl+5uWx1EC5B553t/VuREi8VprLF0k4XvVsY2Oax3c4+OzGOtCg+MvliATMGpbPM/
         iSiLjINeDe3wThKml523g31l/3/Jvn8EscSvxabnDNUO6iclB7YLX7CSlZGUcSL0quv3
         pePQ==
X-Gm-Message-State: APjAAAVbHjrQZf/cT+dEFUTzyPkqcQf4aaqWE3HX2rh07nW91868ur+3
        cclGtc8imtryfABuXdqJMqaeOD3QPrk5gYxZTPAHy9cf
X-Google-Smtp-Source: APXvYqz9dtFs3Jc74gcbECjZGm/sSWe+q8+hiY8NHdIi7mLZBLIqEJyUefrWgN5xRzFZBXUiWZSpyvYKNbQq+KrFcWI=
X-Received: by 2002:a5d:944b:: with SMTP id x11mr8810785ior.305.1580489086059;
 Fri, 31 Jan 2020 08:44:46 -0800 (PST)
MIME-Version: 1.0
From:   Sagar Sawant <sagsaw.sawant@gmail.com>
Date:   Fri, 31 Jan 2020 22:14:34 +0530
Message-ID: <CAP6n3VRhVcnu9e7Y+jj8o-+Z5_jKmLYs8UNFCN+2bf2Pg-yfFg@mail.gmail.com>
Subject: No CPUFREQ or PState is strange
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I have an Intel Pentium Dual Core processor T4500 which neither seems
to be using Intel Pstate not cpufreq but supports speedstep n enabled
in bios ...

Also the fan speed from silent to audible under load indicates that
scaling descaling is happening ...

But nothing in the usual sys devices system cpu cpu0/1 paths ..

Dunno or no way to know whats happening ...

Regards,
Sagar Sawant
