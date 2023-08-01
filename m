Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AF76B3BF
	for <lists+linux-pm@lfdr.de>; Tue,  1 Aug 2023 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjHALsa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 1 Aug 2023 07:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjHALsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 07:48:17 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668361736
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 04:48:14 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56ca74ee539so331528eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2023 04:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690890493; x=1691495293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlLFsbqGdBRpv2hm45cTLpIEjUicm92z7JrPneLl8rs=;
        b=WoTkAT+68XGFEwNEXe6cwW+o6yb/2LC0i3Et6tRdSLenS6RRyGLodIzQARlzd5wdjl
         ougu7AACQ0y89473NaK6gIP84Am1km1G6Kkj8hInwhzMaktYV+jZWdrGmyYZzuFS/pRs
         q3mB5LHQcC9XDv2BRzCJ/el0FkP7Z4HTa6YMYlWcZbHfg5xKKOjoONWQ8MeP62dAEU7b
         Nn5DZChgWXXCHoKOLejCb1gJvMXhhbMpgSJtzi2f2hgaNhY7JdQg/LTOnTDdF1ev6hJw
         uYn1ZOGWdOreRzAg/eeriovfWk6rOXn+SB5xuwY01XVeRpDJ1Hh5Ab07SFg+sgq5jSlx
         5/Xw==
X-Gm-Message-State: ABy/qLbQJAJN6r1AAyIYRTWAr8C2air3E5km7M8+yZQmahESYnyX9v4r
        PoLSIR+5TDgBgPcUXRQg3ALYE7cjFIovYbC/SSU=
X-Google-Smtp-Source: APBJJlFJov5CS24uvPs33yU6/5v/GZT2UeLKsWMchm9h3ZbX/a4N2YmGfePO9CHGNOWK/QWIm1l9hvBAIK9Xmk+0NHI=
X-Received: by 2002:a4a:e251:0:b0:566:951e:140c with SMTP id
 c17-20020a4ae251000000b00566951e140cmr6352476oot.1.1690890493570; Tue, 01 Aug
 2023 04:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <bcce80ed-f2ef-a92f-f7b5-0b14f498d653@linuxfoundation.org>
In-Reply-To: <bcce80ed-f2ef-a92f-f7b5-0b14f498d653@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 13:48:02 +0200
Message-ID: <CAJZ5v0jrf+3xNz9Dt+b6JY5EJTWR1_46yETZ=R0gaVPuKm8SNw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.6-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, trenn@suse.com,
        trenn@suse.de, linux-pm@vger.kernel.org, shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuah,

On Mon, Jul 31, 2023 at 10:42 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.6-rc1.
>
> This cpupower update for Linux 6.6-rc1 consists of 2 fixes and
> enhancements to add support for amd-pstate active mode driver,
> amd_pstate mode change, EPP value change, turbo-boost support,
> and is_valid_path API.
>
> diff is attached.

Pulled and added to the linux-next branch in linux-pm.git, thanks!


> ----------------------------------------------------------------
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>
>    Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.6-rc1
>
> for you to fetch changes up to 99481d2195bfd13a663904e6014887abf46b57c7:
>
>    cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation. (2023-07-18 16:07:08 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.6-rc1
>
> This cpupower update for Linux 6.6-rc1 consists of 2 fixes and
> enhancements to add support for amd-pstate active mode driver,
> amd_pstate mode change, EPP value change, turbo-boost support,
> and is_valid_path API.
>
> ----------------------------------------------------------------
> Ben Hutchings (1):
>        cpupower: Bump soname version
>
> Likhitha Korrapati (1):
>        cpupower: Fix cpuidle_set to accept only numeric values for idle-set operation.
>
> Wyes Karny (5):
>        cpupower: Recognise amd-pstate active mode driver
>        cpupower: Add is_valid_path API
>        cpupower: Add EPP value change support
>        cpupower: Add support for amd_pstate mode change
>        cpupower: Add turbo-boost support in cpupower
>
>   tools/power/cpupower/Makefile                |  2 +-
>   tools/power/cpupower/lib/cpupower.c          |  7 +++
>   tools/power/cpupower/lib/cpupower_intern.h   |  1 +
>   tools/power/cpupower/utils/cpuidle-set.c     | 16 +++----
>   tools/power/cpupower/utils/cpupower-set.c    | 65 +++++++++++++++++++++++++++-
>   tools/power/cpupower/utils/helpers/helpers.h | 11 +++++
>   tools/power/cpupower/utils/helpers/misc.c    | 57 +++++++++++++++++++++++-
>   7 files changed, 146 insertions(+), 13 deletions(-)
> ----------------------------------------------------------------
