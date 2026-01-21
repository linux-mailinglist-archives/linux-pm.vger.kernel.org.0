Return-Path: <linux-pm+bounces-41253-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MlWD6hTcWkKCQAAu9opvQ
	(envelope-from <linux-pm+bounces-41253-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 23:31:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40C5ECFE
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 23:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE74A4C7103
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 22:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CAF43E4A6;
	Wed, 21 Jan 2026 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qeX4Fk0w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884A410D00
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034640; cv=none; b=T5xxNpzKeI+gl7vY/hWvKLZwTJUJJ81TYSz+7Xs2SnCQZfcmfKliKKBvyG7hAop6x29E5C8AHGl7Qu+fcwpWbvutMdwuGy7BcF0xHqwzgycjywFXPuIIS8y/l+ydVw3QkzTxUmQ5xortcSfmxF20ruC3zOSE6ojXVaFr9Sfj2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034640; c=relaxed/simple;
	bh=5hFp/21h+uLKVO4+mY8xnOdOPowH5bBJcZ1ykjeIhj0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ExqM7S9aD3p3SeeoqNix0RZFmdDI4BpWyq8pbwLioZyGgf8BSuRatfcSybJ5ksNWW2w1tXq86RksJsj07oalC1whphW/UKEP+sq+Y5W3FZNUBtUUdu5LbiEyXnDbEJB9RYSm8Q3c4/q2JCbuSe6CGuP8J6U1O2vEw+dd6xRS9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qeX4Fk0w; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc0d7255434so102701a12.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 14:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769034629; x=1769639429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tJn68TPaZpkJplzkCMANwUW6ksbuIjJy5fmGVUej7o=;
        b=qeX4Fk0wDQVMKCAh2knuAbShU42j6Jd4UrWys/czYRdO4G7p04UA7niSbGcnM/MEex
         KnPHKvjmwxyZN057ahC53TJttUlHDQffXqhtG21AamEyklD9/rno3M09oGYU/yzKKgHm
         xnKAGIThS7k/q7L65EfkNwDnoS35YbpSgijdHBMFz4GaF6ew7Y66mO26HgoAZVUQuF3a
         aKqr3swHcMeMUReUJkjISKR9UHZSrXzdZrxefsMdRxEx9oO2954dpxpgD4n7vfxFCMBK
         GwFT19YFS/uNfo7tPn7MATY8Y6Ov5FhSTP4WwbZUYbHqruVeenGtk5Oe0UhszPg81VBi
         RP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769034629; x=1769639429;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0tJn68TPaZpkJplzkCMANwUW6ksbuIjJy5fmGVUej7o=;
        b=lPyLKplSoJBDGraoGN23e50p8aQbluJbMu8O4cZJl+mOqvV2bIUA8Klgvdd78J3oww
         LtNGPRGAdPFI8NV1Im2joMud2gfBOpfGcf0UUIudVapnCbeb8ztPwJz44oX81KzGsw1E
         nAbDPDLxXKgk8EqxrcSxvwV6xWq0AjP/mfMNZQjbcVqKX6zuT50WRW6quusVBGgvbDCC
         U1q50pyEMbUpqsMMLN7dXctOKT63g2wZ30PL13EPiYhnkN1nsYwxV5WMVMJZqGxejyQP
         180GJd2oXXfXlDCkDuSI6ZiYO+wfUPGspdkkWK/9X+aiOts9ggJjimuVsvrF/80mdTne
         XkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEWxr/eoLGFh3z+u4c/AHatDnwE1IcjA4hLk8ITc7MwagxmzO0SvBWXPyZ0NXikGTcXOes4Zo7ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZiNbrPGC0jqTdNcmOcb0Nr3J+YAELIZruB9wDnsJGM+nr0al
	PV7KO12WNoeBNamxEITcz6e5VVF5PdoGmI5oadrgrCES86/eh2tHOuRDktMA/XQvTsA=
X-Gm-Gg: AZuq6aIIzLMUospbhU4WCkc9fUxqsqz+SE+/PiT5jbPQF8kiAH5MAfGrNkJQrK3chQ2
	3Oj8130t9INb7eDf9+J/0JbK5xvnS+EBz2bGssoFOwpOVzvUvUwuMUNtroTDb6tajOF0N9fpmQt
	tno0LnRHAiq7NIBL8t4EKkIUEfzVFkvNcHMVFPfj26vGsyJyfE9puNd1Chi91uXAozOMQJ/g7Ae
	y4rOr1CnwWlm+Bv3AFrcqaXFtMbemmnrPRwj+BG2BlPPLOlK6RV2PeervjRbGQhe6ff1wqR5ATQ
	NG1Q0YfdAR0JvfT/CDsVRMvCE1uGFsoZG3sL16N7LrB2UqIXzGySY8f9Dr6uy01pcItQGE7+riT
	op93tSdqWQFMTLDlc3E1Y+OzS+VnyA0GlIpbOwBQnIT1IOkyH3fXVYpqzmRSCmOuTtwiwAwWxzi
	mt/yWu1uMA
X-Received: by 2002:a17:90b:3889:b0:340:d511:e164 with SMTP id 98e67ed59e1d1-352c4045646mr5200916a91.19.1769034629307;
        Wed, 21 Jan 2026 14:30:29 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335229834sm489801a91.9.2026.01.21.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:30:28 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] of: Add of_parse_map_iter() helper for nexus node
 map iteration
In-Reply-To: <CAL_Jsq+2sFzQb8j5bBWbwgyYn5apLTfWOTZW3+9n74uVyph16A@mail.gmail.com>
References: <20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com>
 <CAL_Jsq+2sFzQb8j5bBWbwgyYn5apLTfWOTZW3+9n74uVyph16A@mail.gmail.com>
Date: Wed, 21 Jan 2026 14:30:28 -0800
Message-ID: <7hwm1ay4xn.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41253-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,baylibre.com:mid,baylibre.com:email]
X-Rspamd-Queue-Id: 5B40C5ECFE
X-Rspamd-Action: no action

Rob Herring <robh@kernel.org> writes:

> +Herve
>
> On Wed, Nov 19, 2025 at 6:41=E2=80=AFPM Kevin Hilman (TI.com)
> <khilman@baylibre.com> wrote:
>>
>> Add a new helper function of_parse_map_iter() to iterate over nexus
>> node maps (c.f. DT spec, section 2.5.1.)
>>
>> This function provides an iterator interface for traversing map
>> entries, handling the complexity of variable-sized entries based on
>> <stem>-cells properties, as well as handling the <stem>-skip and
>> <stem>-pass-thru properties.
>>
>> RFC: There's a lot of overlap between this function and
>> of_parse_phandle_with_args_map().  However the key differences are:
>>
>>   - of_parse_phandle_with_args_map() does matching
>>     it searches for an entry that matches specific child args
>>   - of_parse_map_iter() does iteration
>>     it simply walks through all entries sequentially
>
> There's also this in flight for interrupt-map:
>
> https://lore.kernel.org/all/20251027123601.77216-2-herve.codina@bootlin.c=
om/
>
> There's probably enough quirks with interrupt-map that we can't use
> the same code. Though it may boil down to handling #address-cells and
> how the parent is looked up.

Yeah, as Herve pointed out[1], the interrupt-map has enough quirks that
a generic parser isn't going to work.

>> There are likely ways to extract some shared code between these two
>> functions into some shared helpers, but I'm hoping someone more
>> familiar with this OF code can help here.
>
> I would expect of_parse_phandle_with_args_map() could be implemented
> in terms of the iterator.

OK, let's first get the iterator implementation figured out, and then we
can see if that can be implemented by the iterator.

>> However, before refactoring the shared code, it would be good to have
>> some feedback on this approach.
>>
>> Signed-off-by: Kevin Hilman (TI.com) <khilman@baylibre.com>
>> ---
>>  drivers/of/base.c  | 167 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>>  include/linux/of.h |  13 ++++
>>  2 files changed, 180 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 7043acd971a0..bdb4fde1bfa9 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1594,6 +1594,173 @@ int of_parse_phandle_with_args_map(const struct =
device_node *np,
>>  }
>>  EXPORT_SYMBOL(of_parse_phandle_with_args_map);
>>
>> +/**
>> + * of_parse_map_iter() - Iterate through entries in a nexus node map
>> + * @np:                        pointer to a device tree node containing=
 the map
>> + * @stem_name:         stem of property names (e.g., "power-domain" for=
 "power-domain-map")
>> + * @index:             pointer to iteration index (set to 0 for first c=
all)
>> + * @child_args:                pointer to structure to fill with child =
specifier (can be NULL)
>> + * @parent_args:       pointer to structure to fill with parent phandle=
 and specifier
>> + *
>> + * This function iterates through a nexus node map property as defined =
in DT spec 2.5.1.
>> + * Each map entry has the format: <child_specifier phandle parent_speci=
fier>
>> + *
>> + * On each call, it extracts one map entry and fills child_args (if pro=
vided) with the
>> + * child specifier and parent_args with the parent phandle and specifie=
r.
>> + * The index pointer is updated to point to the next entry for the foll=
owing call.
>> + *
>> + * Example usage::
>> + *
>> + *  int index =3D 0;
>> + *  struct of_phandle_args child_args, parent_args;
>> + *
>> + *  while (!of_parse_map_iter(np, "power-domain", &index, &child_args, =
&parent_args)) {
>> + *      // Process child_args and parent_args
>> + *      of_node_put(parent_args.np);
>> + *  }
>> + *
>> + * Caller is responsible for calling of_node_put() on parent_args.np.
>> + *
>> + * Return: 0 on success, -ENOENT when iteration is complete, or negativ=
e error code on failure.
>> + */
>> +int of_parse_map_iter(const struct device_node *np,
>> +                      const char *stem_name,
>> +                      int *index,
>> +                      struct of_phandle_args *child_args,
>> +                      struct of_phandle_args *parent_args)
>> +{
>> +       char *cells_name __free(kfree) =3D kasprintf(GFP_KERNEL, "#%s-ce=
lls", stem_name);
>> +       char *map_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map",=
 stem_name);
>> +       char *mask_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map-=
mask", stem_name);
>> +       char *pass_name __free(kfree) =3D kasprintf(GFP_KERNEL, "%s-map-=
pass-thru", stem_name);
>> +       static const __be32 dummy_mask[] =3D { [0 ... MAX_PHANDLE_ARGS] =
=3D cpu_to_be32(~0) };
>> +       static const __be32 dummy_pass[] =3D { [0 ... MAX_PHANDLE_ARGS] =
=3D cpu_to_be32(0) };
>> +       const __be32 *map, *mask, *pass;
>> +       __be32 child_spec[MAX_PHANDLE_ARGS];
>> +       u32 child_cells, parent_cells;
>> +       int map_len, i, entry_idx;
>> +
>> +       if (!np || !stem_name || !index || !parent_args)
>> +               return -EINVAL;
>> +
>> +       if (!cells_name || !map_name || !mask_name || !pass_name)
>> +               return -ENOMEM;
>> +
>> +       /* Get the map property */
>> +       map =3D of_get_property(np, map_name, &map_len);
>> +       if (!map)
>> +               return -ENOENT;
>> +
>> +       map_len /=3D sizeof(u32);
>> +
>> +       /* Get child #cells */
>> +       if (of_property_read_u32(np, cells_name, &child_cells))
>> +               return -EINVAL;
>> +
>> +       /* Get the mask property (optional) */
>> +       mask =3D of_get_property(np, mask_name, NULL);
>> +       if (!mask)
>> +               mask =3D dummy_mask;
>> +
>> +       /* Get the pass-thru property (optional) */
>> +       pass =3D of_get_property(np, pass_name, NULL);
>> +       if (!pass)
>> +               pass =3D dummy_pass;
>
> Generally the DT iterators need some state maintained, so there's an
> init function to do all/most of the above and stash that into a state
> struct for the iterator.

OK, I'm assuming you're referring to of_phandle_iterator_init()?

>> +
>> +       /* Iterate through map to find the entry at the requested index =
*/
>> +       entry_idx =3D 0;
>> +       while (map_len > child_cells + 1) {
>> +               /* If this is the entry we're looking for, extract it */
>> +               if (entry_idx =3D=3D *index) {
>> +                       /* Save masked child specifier for pass-thru pro=
cessing */
>> +                       for (i =3D 0; i < child_cells && i < MAX_PHANDLE=
_ARGS; i++)
>> +                               child_spec[i] =3D map[i] & mask[i];
>> +
>> +                       /* Extract child specifier if requested */
>> +                       if (child_args) {
>> +                               child_args->np =3D (struct device_node *=
)np;
>> +                               child_args->args_count =3D child_cells;
>> +                               for (i =3D 0; i < child_cells && i < MAX=
_PHANDLE_ARGS; i++)
>> +                                       child_args->args[i] =3D be32_to_=
cpu(map[i]);
>> +                       }
>> +
>> +                       /* Move past child specifier */
>> +                       map +=3D child_cells;
>> +                       map_len -=3D child_cells;
>> +
>> +                       /* Extract parent phandle */
>> +                       parent_args->np =3D of_find_node_by_phandle(be32=
_to_cpup(map));
>
> Before you update the parent node, you need to put the previous parent.

OK.

Kevin

[1] https://lore.kernel.org/all/20251125085521.451ea208@bootlin.com/

