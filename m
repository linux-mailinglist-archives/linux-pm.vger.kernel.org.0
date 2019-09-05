Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592D0A9B4D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 09:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfIEHLX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 03:11:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40282 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfIEHLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Sep 2019 03:11:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so1120289ota.7
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2019 00:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjoEATD0miVDu7pyOpuxosP++yRn/RCw/ZIg/aUYKR0=;
        b=fznWh2TzWaMa6i2TsTeCViVKg8RKpceMBb4ZvHfmJVqmkCcgRCRTMInwfrChZVfeor
         P+k1Nj2jM+3+5HT7MGi6BxSZug5P2L9ODp57biHy48ktpmt6O8KfKcRefEbbx7EtJnmf
         iMw5qj9MWEoSp0HBJoCutbaLTdgbNgoIhrUqSu6LY45qUFXfipZO5NrqSsivuP6jOQ9M
         zk1EAjg+p16QTZ026C6GcbwchGSdH4lE8YAIk6aLscI12J6ldI66CrNuF6xYm4vZit6/
         0GNdHrubyWlcepcj4G9+50z4/MrZ3cfVYYRd5DJJ7Xqy42XOhrbhsH3OCb+l8K0Cri64
         OlKw==
X-Gm-Message-State: APjAAAV722tt7GR8OSb3+Bt3q4B+M7gjlIrl+zK5gUKeZs+W4sLCPGDi
        0JYwC1KDE59cwrI0UTa8QuHPQYmSpDnrPZEZ41k=
X-Google-Smtp-Source: APXvYqzyAkjFI69Wu1805p5zqO32qNBLwaNHY6C2SCak14T7OLGMIbrYW7p5F74YodPnKfnMPggNCBZFSL3cBSZlCDY=
X-Received: by 2002:a9d:7411:: with SMTP id n17mr1215781otk.118.1567667482165;
 Thu, 05 Sep 2019 00:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190905031645.hvtfuafqt3sjinvb@vireshk-i7>
In-Reply-To: <20190905031645.hvtfuafqt3sjinvb@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Sep 2019 09:11:09 +0200
Message-ID: <CAJZ5v0h0feHdWO0dFTijK-fbGy2YEfhq6dMXtH5Zzu14PPwcqA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP changes for 5.4
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 5, 2019 at 5:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - OPP core fixes to better support genpd devices (Viresh Kumar).
> - OPP core changes to support multiple suspend-opps in DT (Anson Huang).
> - New OPP API (dev_pm_opp_find_level_exact()) and Qcom OPP binding
>   changes for CPR (Niklas Cassel).
> - Qcom minor update (Sricharan R).
> - OPP Documentation fix (Yue Hu).
> - OPP core support to enable/disable regulators (k.konieczny).
>
> --
> viresh
>
> -------------------------8<-------------------------
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 071afa50609d46f2f760851b90696f9a09714d24:
>
>   Merge branch 'opp/qcom-updates' into opp/linux-next (2019-09-03 07:54:17 +0530)

Pulled and pushed out, thanks!
