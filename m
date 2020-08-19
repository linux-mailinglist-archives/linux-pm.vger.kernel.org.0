Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0803C24A3E3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHSQUN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 12:20:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46203 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHSQT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 12:19:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id v13so21473370oiv.13
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 09:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpCt473ya8xw9rTEZtCQT8AbtzVuKhnKSf/kRHyAZPg=;
        b=qk76e+ULP3Y//Q+IP/kreTjhSBmrxxm8d4xrpb3IoTqZVYP0Uh4DJQtQA/YUhSL59v
         syXgDHSeo5/PSJ+OV1Ng0NCHEX3q/dhVX2jewYCs3k9iuM72rrRCh7MEGPHKoRCrtDob
         aRaJ6pxyzcImmbQTvN1RIX6XFjWGnsRiT29UjboxlIaAmHloNXCA07lN9jTSK0isiftW
         Dwm/iuvBxDBT8yLeANj8AJtAlsSVok1bl8t1Rhf1qWjSJQjZ/K8lOwXO/0cWeebGxour
         TPMGDO2SsCRGxejGb9Q/jcMSZ3MV0oWUjcxvdeHTAWWFXNSno4TqPAF3pPk219Y5hj4o
         p3JQ==
X-Gm-Message-State: AOAM530Kw31EGLuaFA9ee+gYshB0K1RkVdF3VQ1etTYCVY1sBpUI0Jup
        eOyfY6K0sNFDBgYgptK6Am5vv/osT6hYwca7Y2j9Wbty
X-Google-Smtp-Source: ABdhPJzX9w+GvTI1X5YukOXxwm58QsqgPrhNRk/G/PCv20RWrhf7/RBjjdepkUHMtwuBk4XxsGMAFQLrYLPEhPTSOW4=
X-Received: by 2002:aca:110a:: with SMTP id 10mr3619886oir.68.1597853994202;
 Wed, 19 Aug 2020 09:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200819124850.akwnkeyek4cj7bzj@vireshk-i7>
In-Reply-To: <20200819124850.akwnkeyek4cj7bzj@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Aug 2020 18:19:42 +0200
Message-ID: <CAJZ5v0j734C0CKFS2cQ3UKFGvDAO8OjBdi8tgwnj+Tng8XzVXA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.9-rc2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, Aug 19, 2020 at 2:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following fixes for 5.9:
>
> - Fix re-enabling of resources (Rajendra Nayak).
>
> - Put OPP table references (Stephen Boyd).
>
> -------------------------8<-------------------------
>
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
>
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/fixes
>
> for you to fetch changes up to ceac7fc18ac7c1d0ad74222e349b24f69c87f1e8:
>
>   opp: Enable resources again if they were disabled earlier (2020-08-17 10:37:11 +0530)

Pulled, thanks!
