Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C551331DE6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 05:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCIEby (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 23:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCIEbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 23:31:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1072AC06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 20:31:24 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y13so5177873pfr.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 20:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hBH1FhllMri9rF1DT2YCV1l2bm6F2LmMgOalJdMipVk=;
        b=KxOCdGXTa4LyL7Ri2mhWnB7ZCFqadqIs1Z9R/blMomYa723ZnPP4j3Zdgzzuy0Fm4G
         3K6c4g0mdmk8cOI0qPt9yu0GNZewSy5Cu3GXwgs8ZXaeNeItkPAbASYeGvxcqgM1v6hC
         Qw0UYd8Okj05Ev3EdeFg+rk0mHd8NqVdU/Rb217s26xCQU13u5Vwayw5Qrkka2KanpCI
         7RYOgHm5tKQZZWsLSOM/HbxyVn+WZ5kxTyLXKeddYMoKBtgNw+ZoeidFSHKpO/CerZGB
         cgCWUW+xzYzTyJCNlCclO/IZ0SmKQbJ4nq89p1g/+T8yzkGJ5oxONrOE/bXOdpZpPpat
         eHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hBH1FhllMri9rF1DT2YCV1l2bm6F2LmMgOalJdMipVk=;
        b=nhTzWNRk9kY05YTiLPIMEBOHWz6SGN8e8RgVf0s3mEDgq2NS68SDbhSJG48fLdeklP
         QPAIz8evOXJFDBffWESRiAhd9ahvpCQ5f6qjGmv2R0PRSJUCplRIyccp5Y120qZrxQwx
         u8rUjIjoI6PiLGOGFddAPI4WKdc9MdJmIbHMSFRir5muTw0UI+vhMo4kVgTYvCxkvSEn
         jYg1xJQLyx/qYXnNEbmZwGjF7ug+lcPZ4YTCG9bs2D95cYEr6PEPhN/xPm5WCRJzopW/
         H1od1LoCKutzOv2l6Br9jWRNTRPsL3Zp3oJMZd2sKAnMQ9R1vX6egLexKNhbdY9AWKj/
         V3FA==
X-Gm-Message-State: AOAM531F+5m/snRwcIfIlUbREneU7V1XIm7pWgnsE7Kn2143alxwTFh2
        AHHgNruvECmmf/Qz5pjrZM2nmQ==
X-Google-Smtp-Source: ABdhPJwQmLKlgimkdb9kzioPgIPReBuxOw9qT+ShYO30OhonzCs43kZCaxEFopYaO45cJYeKeraRew==
X-Received: by 2002:a62:76c5:0:b029:1f2:e6af:e2ab with SMTP id r188-20020a6276c50000b02901f2e6afe2abmr13112685pfc.10.1615264283568;
        Mon, 08 Mar 2021 20:31:23 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id y20sm11533912pfo.210.2021.03.08.20.31.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 20:31:22 -0800 (PST)
Date:   Tue, 9 Mar 2021 10:01:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
Message-ID: <20210309043121.546mlvl4jmshogor@vireshk-i7>
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
 <20210305042401.gktrgach4dzxp7on@vireshk-i7>
 <418fc3cb-d5ec-9216-269a-e055e78718e5@arm.com>
 <20210308115053.ua2gfo6kfnfjslyd@vireshk-i7>
 <20210308181446.GA26783@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308181446.GA26783@e120325.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-03-21, 18:14, Beata Michalska wrote:
> > -bool _opp_remove_all_static(struct opp_table *opp_table)
> > +/*
> > + * Can't remove the OPP from under the lock, debugfs removal needs to happen
> > + * lock less to avoid circular dependency issues. This must be called without
> > + * the opp_table->lock held.
> > + */
> > +static int _opp_drain_list(struct opp_table *opp_table, bool dynamic)
> >  {
> > -	struct dev_pm_opp *opp;
> > +	struct dev_pm_opp *opp, *current_opp = NULL;
> > +	int count = 0;
> > +
> > +	while ((opp = _opp_get_next(opp_table, dynamic))) {
> > +		if (opp_table->current_opp == opp) {
> > +			/*
> > +			 * Reached at current OPP twice, no other OPPs left. The
> > +			 * last reference to current_opp is dropped from
> > +			 * _opp_table_kref_release().
> > +			 */
> > +			if (current_opp)
> > +				break;
> > +
> > +			current_opp = opp;
> > +		}
> Having a quick look at the code ...
> Shouldn't the current_opp be moved at the end of the list ?
> Otherwise there is a risk of leaving unreferenced opps (and opp_table).

How exactly ? Note that it is expected that the OPP table isn't being
used by anyone anymore at this point and all the users went away.

> Might be also worth adding warning (?)
> 
>     WARN_ONCE(!list_is_singular())

It is allowed for the list to contain both static and dynamic OPPs,
and so the list may have more OPPs here.

-- 
viresh
