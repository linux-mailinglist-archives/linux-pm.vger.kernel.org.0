Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F96E14C31D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2020 23:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1Wob (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 17:44:31 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32967 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1Wob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 17:44:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so12110524oig.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 14:44:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8OCor50dbz87HysQnsFchVbiY0ND5uEbG8IYejs9vQ=;
        b=oVuqBcGY9XnimWe9+Gx9TKgXJ3iEhsJP9yBzaqFh6BvSWrzZCUk3z2nFCAjQecqsBL
         mzdkBeh2YmN8cie0Cpt1cYsfsvG4bgk/lkjdrAdU/9r/sVPvHzvaPmQU3WwbS5I7Vly8
         oiR1zaRtSbDMHxn41L7ABa5Jsf9vWHBhiAhA6QJ9jp5EQcLsHrWccRmTXRDvFa/dWdxv
         lB2doFSRdBX5sEOBq3a+7M9ksu6wlL0FtNyX+gyOtMedEH8tVmMPmFyYt5sUKDZ0rEmS
         4NDaigvvGAQZ24AqW77kMEEEsm4QBzXph94f3qtNsnq9Bq+leym44m2ARYaBnFERst1+
         X3Yw==
X-Gm-Message-State: APjAAAXQjQKUusxxtqQKm3awyxyBpgd12Eia+utMK1AIo1TNATUQxp6D
        maSm6shKbVk5xSpN0cGCc6Zzex8xmShcnuXk8IjtoA==
X-Google-Smtp-Source: APXvYqxgqYOUbWCVib/7eC4DX5a7UZShrtpk7WirAFPs+YkexJEKfg+HPoz/xTBNuGJr8vbHFWJsL1JjVv3l1auaLDg=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr4632068oiy.110.1580251470543;
 Tue, 28 Jan 2020 14:44:30 -0800 (PST)
MIME-Version: 1.0
References: <7c92807e-073e-c2a1-e229-9b5d5dd24f14@linuxfoundation.org>
In-Reply-To: <7c92807e-073e-c2a1-e229-9b5d5dd24f14@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jan 2020 23:44:19 +0100
Message-ID: <CAJZ5v0hq5J0KCrqkQV=B-orZrF5w7VzSENieJs+r9SGREusd+g@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.6-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.com>, latha@linux.vnet.ibm.com,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 28, 2020 at 7:36 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following update for Linux 5.6-rc1.
>
> This cpupower update for Linux 5.6-rc1 consists of a revert from
> Thomas Renninger and a manpage correction from Brahadambal Srinivasan.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
>
> ----------------------------------------------------------------
> The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:
>
>    Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux
> tags/linux-cpupower-5.6-rc1
>
> for you to fetch changes up to 8c30fa7666ff08dad632411d1a9b9883940e53ef:
>
>    Correction to manpage of cpupower (2020-01-27 08:43:31 -0700)

Pulled, thanks!
