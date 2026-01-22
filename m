Return-Path: <linux-pm+bounces-41256-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCyRF2R6cWkvHwAAu9opvQ
	(envelope-from <linux-pm+bounces-41256-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 02:16:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F68603AF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 02:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C70433C891C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042F31E0F2;
	Thu, 22 Jan 2026 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zym84CyM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0F313E30
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044572; cv=none; b=fIeuWCWMPCImsti2Kp1hN3juAWDs72QSoMu51nVZ7p7WhN+xZgIW/h9ViM0Av3E4Pc/F0xcP9H9dOEH05m7caxVxKu5UdDKy2vBq1qXcf2jrRgHKGe4Owrv7YL33tWmCn6fQDMglfCnkqTXfLHbS6D3rOij2U6QelUbn70zEags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044572; c=relaxed/simple;
	bh=jqqaW2BxxsmEU0aFqYQDCxb3LGBQ3x2DI42L84wdJmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J/7+TeuYm7U3xFqA7JPH3eu+P0hS5djMRJhDjsrm5YFNIeAOs+9AA3woCLghMlDecRiU+H4bV6nNlVXKOK0YBmWFynqWZ5VlYx4c3+KtjTqVFEEvqj+iFg+LWSWBWYlRQJqeUhhq5DmgPerA1IGooDJb03PZ3stSHEzQnz3dXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zym84CyM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so443621b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 17:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769044564; x=1769649364; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lGeSjZ9YQbprMhk0/2IWvvFkHe84g+iu/Za5NoKtD6w=;
        b=zym84CyMNg7Hs8dMw9BMItXV/qGhaIHmkwTxxf59rVH3tNarStBAj788ED1922nbxt
         XZ0TUXp1xbgiLXay+gGPK+vWnk5GjJNOGBit7yEpSctF5wN8FTqMmJ3Oa0FWmtGetiIT
         KCjEPe0swzwaUGyLz5fMzKtp5Q/Wqfrqj0usItPvXbGhU1KOZWXnf67VeA3eztDX299M
         p2xZfqD5JskebXb1ZWc8kyAwkrn5MEEcHweZl/b1F/DughLcWtoUmAg9mAi4nwH1TdYG
         +Wl1QWl1ldkBNrrz/R9vZeIYB+DnDp130pCyasL6PPabHmD0RoIC7ukMvRMH7rKhF+92
         aeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769044564; x=1769649364;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGeSjZ9YQbprMhk0/2IWvvFkHe84g+iu/Za5NoKtD6w=;
        b=DYnwYIb6P5IUmwAyCA/6AoxkPUonOH5jntLpxJN/MwlWnUhL8t65weyI5SUJ1u+5pp
         aqzmmM6k30ROXNc7KFNZjQZodG2WyyYSjlfDmQ7rLcQh+2wynE2jXg9dFA0TNaB+G+hi
         vNmxJXMctPujD2dOLPzzrf4+DV4uUzxa/mW4b24r9RsAeA97VtWg9ignKgWeFnacetj8
         uvA6+gS008rVAZNligcEssgRLdjmtKK+GFNjpxk4INdHsmRMAv98Z3vyJBt99xtBvLka
         F0PCB04Y4Q1bcb4SpiG6djSTDFUeM2g8msQTmlRzkV+1Kc0cmunW9T5VBw9XzLiWffYL
         9ljg==
X-Forwarded-Encrypted: i=1; AJvYcCUtTdUO/XNc9CTJzlsOAIza5NXKcITNfmNGd/3CDXmakKm9sjuTr9QQGNDylvCv8tz/ABo38Qtp4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWgytDHTkSXFfZ7ixycVvM61u8IrzwDi9awVgJevyVmtlmtzC
	LSJI+XTtWDaaTrdEkJXtWYUMnLDqg6b2TrhoHRJD+cwIQ9qgESV2hgN1si6Sol4n4js=
X-Gm-Gg: AZuq6aIK7SLpcBbvReu1Orxd2zSn4kPQ6mICUv26Mb6xPFMsq9wkR1xY+LYurLvzYHp
	T7FnzhxMeXXdYcrMZuLk/XOPOBJLsT+JGzUmvZKyxTFT5L1qLyw6fK0xDk80ZbRN2pUE1NQ3s7M
	nqE9jeApzTR9rBTBFKtLjrWedi1DQyELKuVwbp7nEjyij2YFYZfDJnapj7drzYTkrxjuUulQZBd
	avSDyaPzg4rQ2hULyvizj+VUbJDR7sJax2Bnt9X6F9VGU4eWIQUUHAtQ3xz6WQ2LVvfk8en794N
	TVeMaww4TWSSYN/X69GHaKi7exjakd5ESrAynJ9lJeOc+8vH8LZsUSX4a8Oy+qQVQLfq7OZhtmY
	4k7EHQw7rVhWckuMZeFw0k9OxmDYD2fC6fmZguHXhjXqOnrDLB7HHRPJDtCTHQDxalmAuaPd2oT
	cs5Vrfa6wm
X-Received: by 2002:a05:6a00:27a3:b0:821:81ef:5dec with SMTP id d2e1a72fcca58-82181ef6acdmr1855521b3a.8.1769044563642;
        Wed, 21 Jan 2026 17:16:03 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b21fsm16266577b3a.13.2026.01.21.17.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 17:16:03 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/2] pmdomain: core: support domain hierarchy via
 power-domain-map
In-Reply-To: <CAPDyKFoU10ASgtXVUiCyj+rWehkMhkX=w=W1ieTksPdpskUN0Q@mail.gmail.com>
References: <20251119-pmdomain-hierarchy-onecell-v4-0-f25a1d5022f8@baylibre.com>
 <20251119-pmdomain-hierarchy-onecell-v4-1-f25a1d5022f8@baylibre.com>
 <CAPDyKFoU10ASgtXVUiCyj+rWehkMhkX=w=W1ieTksPdpskUN0Q@mail.gmail.com>
Date: Wed, 21 Jan 2026 17:16:02 -0800
Message-ID: <7hpl72wip9.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41256-lists,linux-pm=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_PROHIBIT(0.00)[0.0.0.11:email];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,linaro.org:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,parent_args.np:url,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: C0F68603AF
X-Rspamd-Action: no action

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Thu, 20 Nov 2025 at 01:58, Kevin Hilman (TI.com)
> <khilman@baylibre.com> wrote:
>>
>> Add of_genpd_add_subdomain_map() helper function to support
>> hierarchical PM domains defined by using power-domains-map
>> property (c.f. nexus node maps in DT spec, section 2.5.1).
>>
>> This enables PM domain providers with #power-domain-cells > 0 to
>> establish subdomain relationships via the power-domain-map property,
>> which was not previously possible.
>>
>> This new helper function
>> - uses an OF helper to iterate to over entries in power-domain-map
>> - For each mapped entry: extracts child specifier, resolves parent phandle,
>>   extracts parent specifier args, and establishes subdomain relationship
>> - Uses genpd_add_subdomain() with proper gpd_list_lock mutex protection
>>
>> Example from k3-am62l.dtsi:
>>
>>   scmi_pds: protocol@11 {
>>       #power-domain-cells = <1>;
>>       power-domain-map = <15 &MAIN_PD>,  /* TIMER0 */
>>                          <19 &WKUP_PD>;  /* WKUP_TIMER0 */
>>   };
>>
>>   MAIN_PD: power-controller-main {
>>       #power-domain-cells = <0>;
>>   };
>>
>>   WKUP_PD: power-controller-main {
>>       #power-domain-cells = <0>;
>>   };
>>
>> This allows SCMI power domain 15 to become a subdomain of MAIN_PD, and
>> domain 19 to become a subdomain of WKUP_PD.
>
> Nitpick:
> As long as possible, please use the terminology "parent-domain" and
> "child-domain" and avoid "subdomain". There are a couple of cases of
> this, in the code too, can you please update all of them?

OK.

>>
>> Signed-off-by: Kevin Hilman (TI.com) <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/core.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h |  9 +++++++
>>  2 files changed, 73 insertions(+)
>>
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 61c2277c9ce3..592e9126896c 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -3483,6 +3483,70 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>>  }
>>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>>
>
> We need to add some description of the function here.

OK.

>> +int of_genpd_add_subdomain_map(struct device_node *np,
>
> Nitpick:
> Hmm, either we should keep consistency with the name
> "of_genpd_add_subdomain", according to what you propose - or we should
> take the opportunity to move to use "child" in the name instead
> (of_genpd_add_child_domain_map()).
>
> Sooner or later it would be nice if we could rename
> of_genpd_add_subdomain() (and friends) to of_genpd_add_child_domain().
>
> No big deal at this point, I am fine with whatever name you decide to use.

I will update the changelogs/comments/descriptions etc. to use
parent/child, but I will leave subdomain in the function name since
that's what all the other APIs use.  Then in a later cleanup step, we
could rename the subdomain APIs to child APIs.

>> +                              struct genpd_onecell_data *data)
>> +{
>> +       struct generic_pm_domain *genpd, *parent_genpd;
>
> Maybe use "child" and "parent" as variable names instead. This should
> make the code a bit more clear.

OK.

>> +       struct of_phandle_args child_args, parent_args;
>> +       int index = 0;
>> +       int ret = 0;
>> +       u32 child_index;
>> +
>> +       if (!np || !data)
>> +               return -EINVAL;
>> +
>> +       /* Iterate through power-domain-map entries using the OF helper */
>> +       while (!of_parse_map_iter(np, "power-domain", &index,
>> +                                  &child_args, &parent_args)) {
>> +               /* Extract the child domain index from the child specifier */
>> +               if (child_args.args_count < 1) {
>
> This should be exactly 1, right?

Hmm, I'm not sure exactly what you mean.  Are you suggesting this check
should be "!= 1" instead of "< 1"?

I think args_count should match #power-domain-cells.  So for SCMI, this
should indeed be 1.  But if this function is used for other domains
where #power-domain-cells is > 1, then the current check for "< 1" is
correct.

>> +                       of_node_put(parent_args.np);
>> +                       ret = -EINVAL;
>> +                       break;
>
> If we fail here, we should remove child domains that we added for the
> earlier indexes in the while loop, rather than just bailing out.
>
> This applies to other error paths below too.

Yeah, the current error handling isn't really in place (hence the RFC)
but I will add it for the next version.

I'm planning to take the approach that all children in the map have to
be successfully added in order for this function to be considered
successful.  If any of the children fail to get added (for any reason),
then they all should be removed.

This remove function will look *very* similar to the add function
because it will have to parse the map (again), finding parent and child
info and attempting to remove each child from the parent.

At first, this seems pretty inefficient, but I think it's better than
the add function being required to keep track of the state of which
domains were successfully added.  Which gets even more complicated if
there are multiple domains which use power-domain-map.

So fora now, I plan to avoid tracking all that state, and have the
remove function be a simple reversal of the add, but looping through the
whole map, even if it fails to remove some items (because they may not
have been added in the first place.)

>> +               }
>> +               child_index = child_args.args[0];
>> +
>> +               /* Validate child domain index */
>> +               if (child_index >= data->num_domains) {
>> +                       of_node_put(parent_args.np);
>> +                       continue;
>
> I don't think we should just continue here, but instead treat this as an error.

Yes.

>> +               }
>> +
>> +               genpd = data->domains[child_index];
>> +               if (!genpd) {
>> +                       of_node_put(parent_args.np);
>> +                       continue;
>
> Ditto.

Yes.

>> +               }
>> +
>> +               /* Get parent power domain from provider and establish subdomain relationship */
>> +               mutex_lock(&gpd_list_lock);
>> +
>> +               parent_genpd = genpd_get_from_provider(&parent_args);
>> +               if (IS_ERR(parent_genpd)) {
>> +                       mutex_unlock(&gpd_list_lock);
>> +                       of_node_put(parent_args.np);
>> +                       ret = PTR_ERR(parent_genpd);
>> +                       dev_err(&genpd->dev, "failed to get parent domain: %d\n", ret);
>
> Perhaps clarify the print by changing the text to state that we can't
> find the parent's OF provider. If the print is needed at all.

Print probably isn't needed at all, but just useful for development
debug purposes.

>> +                       break;
>> +               }
>> +
>> +               ret = genpd_add_subdomain(parent_genpd, genpd);
>> +               mutex_unlock(&gpd_list_lock);
>> +               of_node_put(parent_args.np);
>> +
>> +               if (ret) {
>> +                       dev_err(&genpd->dev, "failed to add as subdomain of %s: %d\n",
>> +                               parent_genpd->name, ret);
>> +                       break;
>> +               }
>> +
>> +               dev_info(&genpd->dev, "added as subdomain of %s\n",
>> +                       parent_genpd->name);
>> +       }
>> +
>> +       return ret;
>> +}
>
> Except for taking better care in the error path, it also looks like we
> are missing a corresponding function to remove the child-domains that
> was added with the above new function.
>
> Perhaps that function can be used in the error paths too?

Yeah, I as describe above.  I will add that for the next version.

Kevin

